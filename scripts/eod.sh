#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/env.sh"

echo ""
echo "🌙 Geo-Sentinel EOD"
echo ""

echo "📦 Git status"
git -C "$GEO_ROOT" status

echo ""
echo "📋 Terraform plan snapshot (env: $TF_ENV)"
"$GEO_ROOT/scripts/tf.sh" "$TF_ENV" plan

echo ""
echo "⚙ Generating automation helper: scripts/recreate-infra.sh"

cat > "$GEO_ROOT/scripts/recreate-infra.sh" <<'SH'
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
SH

chmod +x "$GEO_ROOT/scripts/recreate-infra.sh"
echo "✔ recreate-infra.sh generated"

echo ""
echo "🧾 Writing EOD snapshot: scripts/bootstrap/last-known-good.md"
mkdir -p "$GEO_ROOT/scripts/bootstrap"

# Ensure backend/init is ready before reading outputs
"$GEO_ROOT/scripts/tf.sh" "$TF_ENV" init >/dev/null

# Capture snapshot values
SNAP_DATE="$(date)"
SNAP_BRANCH="$(git -C "$GEO_ROOT" branch --show-current)"
SNAP_COMMIT="$(git -C "$GEO_ROOT" rev-parse HEAD)"
SNAP_SHORT="$(git -C "$GEO_ROOT" rev-parse --short HEAD)"
TF_VERSION="$(terraform version | head -n 1)"
AWS_VERSION="$(aws --version 2>&1)"
TF_OUTPUTS="$(terraform -chdir="$GEO_ROOT/infra/terraform" output 2>/dev/null || echo "No outputs (infra may be destroyed).")"

cat > "$GEO_ROOT/scripts/bootstrap/last-known-good.md" <<MD
# Geo-Sentinel — Last Known Good (EOD Snapshot)

- Date (local): ${SNAP_DATE}
- Git branch: ${SNAP_BRANCH}
- Git commit: ${SNAP_COMMIT}
- Git short:  ${SNAP_SHORT}

## Environment
- TF_ENV: ${TF_ENV}
- AWS_PROFILE: ${AWS_PROFILE:-default}
- AWS_REGION: ${AWS_REGION}

## Terraform
- Terraform: ${TF_VERSION}
- AWS CLI: ${AWS_VERSION}

## Terraform Outputs (if infra exists)
\`\`\`
${TF_OUTPUTS}
\`\`\`

## State Sync Reminder (LOCAL STATE MODE)
If switching machines before next Terraform run, sync:
- infra/terraform/terraform.tfstate
- infra/terraform/terraform.tfstate.backup (if present)
- infra/terraform/.terraform.lock.hcl
MD

echo "✔ Snapshot updated"
