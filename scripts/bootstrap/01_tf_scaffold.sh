#!/usr/bin/env bash
set -euo pipefail

# Run from anywhere; we want repo root as working dir.
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${REPO_ROOT}" ]]; then
  echo "❌ Not inside a git repository. cd into geo-sentinel and try again."
  exit 1
fi
cd "${REPO_ROOT}"

echo "📍 Repo root: ${REPO_ROOT}"

# Create folders
mkdir -p infra/terraform/{modules,envs/dev,envs/prod,bootstrap}
echo "✅ Created directories under infra/terraform"

# Create base files (won't overwrite content if files already exist)
for f in \
  infra/terraform/providers.tf \
  infra/terraform/versions.tf \
  infra/terraform/variables.tf \
  infra/terraform/outputs.tf \
  infra/terraform/main.tf \
  infra/terraform/README.md \
  infra/terraform/bootstrap/backend.tf \
  infra/terraform/bootstrap/README.md \
  infra/terraform/envs/dev/terraform.tfvars \
  infra/terraform/envs/dev/backend.hcl \
  infra/terraform/envs/prod/terraform.tfvars \
  infra/terraform/envs/prod/backend.hcl
do
  if [[ -e "$f" ]]; then
    echo "↪️  Exists: $f (skipping)"
  else
    mkdir -p "$(dirname "$f")"
    touch "$f"
    echo "🆕 Created: $f"
  fi
done

echo
echo "📦 Files created/verified:"
find infra/terraform -maxdepth 3 -type f | sort

echo
echo "✅ Step 1 scaffold complete."
