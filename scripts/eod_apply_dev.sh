#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== Geo-Sentinel EOD APPLY (dev) =="
echo "Repo: $ROOT_DIR"
echo

# Quick identity + region sanity
if command -v aws >/dev/null 2>&1; then
  echo "== AWS identity =="
  aws sts get-caller-identity || true
  echo
  echo "== AWS configure list =="
  aws configure list || true
  echo
else
  echo "⚠️ aws CLI not found. Install AWS CLI to run identity checks."
  echo
fi

echo "== Terraform init/validate/plan/apply (dev) =="
./scripts/tf.sh dev init
./scripts/tf.sh dev validate
./scripts/tf.sh dev plan
./scripts/tf.sh dev apply
echo

echo "== Terraform outputs =="
terraform -chdir=infra/terraform output || true
echo

# Lightweight post-checks (region assumed from your tfvars/defaults)
REGION="$(terraform -chdir=infra/terraform output -raw vpc_id >/dev/null 2>&1 && echo eu-central-1 || echo eu-central-1)"

if command -v aws >/dev/null 2>&1; then
  VPC_ID="$(terraform -chdir=infra/terraform output -raw vpc_id 2>/dev/null || true)"
  if [[ -n "${VPC_ID}" ]]; then
    echo "== Verify VPC exists (${REGION}) =="
    aws ec2 describe-vpcs --vpc-ids "$VPC_ID" --query "Vpcs[0].VpcId" --output table --region "$REGION" || true
    echo

    echo "== Verify VPC endpoints (${REGION}) =="
    aws ec2 describe-vpc-endpoints \
      --filters "Name=vpc-id,Values=$VPC_ID" \
      --query "VpcEndpoints[].ServiceName" \
      --output table --region "$REGION" || true
    echo

    echo "== Verify security groups (${REGION}) =="
    aws ec2 describe-security-groups \
      --filters "Name=vpc-id,Values=$VPC_ID" \
      --query "SecurityGroups[].GroupName" \
      --output table --region "$REGION" || true
    echo
  else
    echo "ℹ️ VPC output not found yet; skipping AWS resource verification."
  fi
fi

echo "✅ EOD APPLY (dev) complete."
