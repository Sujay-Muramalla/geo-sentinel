#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "== Geo-Sentinel EOD DESTROY (dev) =="
echo "Repo: $ROOT_DIR"
echo

echo "⚠️ This will DESTROY Terraform-managed resources for dev."
read -r -p "Type DESTROY to continue: " CONFIRM
if [[ "${CONFIRM}" != "DESTROY" ]]; then
  echo "Aborted."
  exit 0
fi

echo
echo "== Terraform destroy (dev) =="
./scripts/tf.sh dev init
./scripts/tf.sh dev destroy
echo

echo "== Post-check (best effort) =="
if command -v aws >/dev/null 2>&1; then
  echo "AWS identity (for audit):"
  aws sts get-caller-identity || true
fi

echo "✅ EOD DESTROY (dev) complete."
