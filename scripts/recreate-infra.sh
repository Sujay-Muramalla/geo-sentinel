#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "♻️ Recreating Geo-Sentinel infra from repo state:"
git rev-parse --short HEAD || true

# Load environment defaults
source "$ROOT_DIR/scripts/env.sh"

echo "🔎 Pre-flight"
"$ROOT_DIR/scripts/tf.sh" "$TF_ENV" init
"$ROOT_DIR/scripts/tf.sh" "$TF_ENV" plan

echo ""
read -p "Apply changes to recreate infra? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
  echo "Abort."
  exit 0
fi

"$ROOT_DIR/scripts/tf.sh" "$TF_ENV" apply

echo ""
echo "✅ Recreate complete. Outputs:"
terraform -chdir="$ROOT_DIR/infra/terraform" output || true
