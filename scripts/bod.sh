#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/env.sh"

echo ""
echo "🌅 Geo-Sentinel BOD Checks"
echo "=========================="

echo "📦 Git status"
git status

echo ""
echo "🔄 Pull latest changes"
git pull

echo ""
echo "🔧 Toolchain check"

echo "Terraform:"
terraform version | head -n 1

echo "AWS CLI:"
aws --version

echo ""
echo "👤 AWS identity"
aws sts get-caller-identity

echo ""
echo "🧪 Terraform validation"

cd "$TF_DIR"
terraform fmt -recursive
terraform validate

echo ""
echo "📋 Infrastructure plan"

"$GEO_ROOT/scripts/tf.sh" "$TF_ENV" plan

echo ""
echo "✅ BOD checks complete"
