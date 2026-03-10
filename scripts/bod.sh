#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/env.sh"

APPLY=false
if [[ "${1:-}" == "--apply" ]]; then
  APPLY=true
fi

ORIGINAL_BRANCH="$(git branch --show-current 2>/dev/null || true)"

echo ""
echo "🌅 Geo-Sentinel BOD Checks"
echo "=========================="

echo "📦 Git status"
git status

echo ""
echo "🔄 Sync develop"
git fetch --prune origin

CURRENT_BRANCH="$(git branch --show-current 2>/dev/null || true)"

if [[ "$CURRENT_BRANCH" != "develop" ]]; then
  git switch develop
fi

git pull --ff-only origin develop

if [[ -n "$ORIGINAL_BRANCH" && "$ORIGINAL_BRANCH" != "develop" ]]; then
  echo ""
  echo "↩️ Restoring working branch: $ORIGINAL_BRANCH"
  git switch "$ORIGINAL_BRANCH"
fi

echo ""
echo "🔧 Toolchain check"
echo "Terraform: $(terraform version | head -n 1)"
echo "AWS CLI:    $(aws --version)"

echo ""
echo "👤 AWS identity (profile: ${AWS_PROFILE:-default}, region: ${AWS_REGION:-eu-central-1})"
aws sts get-caller-identity

echo ""
echo "🧪 Terraform format + validate"
cd "$TF_DIR"
terraform fmt -recursive
terraform validate

echo ""
echo "📋 Terraform plan (env: $TF_ENV)"
"$GEO_ROOT/scripts/tf.sh" "$TF_ENV" plan

if [[ "$APPLY" == "true" ]]; then
  echo ""
  echo "🚀 Applying (env: $TF_ENV)"
  "$GEO_ROOT/scripts/tf.sh" "$TF_ENV" apply
else
  echo ""
  echo "ℹ️ Plan complete. To restore/create infra automatically, run:"
  echo "   ./scripts/bod.sh --apply"
fi

echo ""
echo "✅ BOD complete"
