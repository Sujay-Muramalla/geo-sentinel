#!/usr/bin/env bash
set -euo pipefail

echo "🌍 Loading Geo-Sentinel environment..."

# Project root
export GEO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Terraform directory
export TF_DIR="$GEO_ROOT/infra/terraform"

# Default environment
export TF_ENV="${TF_ENV:-dev}"

# AWS defaults
export AWS_REGION="${AWS_REGION:-eu-central-1}"

# Load Terraform .env if present
if [[ -f "$TF_DIR/.env" ]]; then
  echo "🔐 Loading Terraform env file"
  set -a
  source "$TF_DIR/.env"
  set +a
fi

echo "✔ Environment ready"
echo "Project root: $GEO_ROOT"
echo "Terraform dir: $TF_DIR"
echo "Environment: $TF_ENV"
echo "AWS region: $AWS_REGION"
