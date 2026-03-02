#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_DIR="$ROOT_DIR/infra/terraform"
ENV_FILE="$TF_DIR/.env"

ENVIRONMENT="${1:-dev}"
shift || true

TFVARS="$TF_DIR/envs/$ENVIRONMENT/terraform.tfvars"

if [[ ! -f "$TFVARS" ]]; then
  echo "❌ Env tfvars not found: $TFVARS"
  echo "Usage: ./scripts/tf.sh <dev|prod> <terraform-cmd> [args...]"
  exit 1
fi

# Load env vars if file exists
if [[ -f "$ENV_FILE" ]]; then
  echo "🔐 Loading env from: $ENV_FILE"
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
else
  echo "ℹ️ No env file found at $ENV_FILE (skipping)"
fi

cd "$TF_DIR"

# Terraform subcommand (init/plan/apply/validate/etc.)
CMD="${1:-}"
if [[ -z "$CMD" ]]; then
  echo "❌ Missing terraform command."
  echo "Usage: ./scripts/tf.sh <dev|prod> <terraform-cmd> [args...]"
  exit 1
fi

# Shift off the terraform command
shift || true

# Only some commands accept -var-file. validate does NOT.
case "$CMD" in
  plan|apply|destroy|refresh|import|console)
    terraform "$CMD" "$@" -var-file="$TFVARS"
    ;;
  *)
    terraform "$CMD" "$@"
    ;;
esac
