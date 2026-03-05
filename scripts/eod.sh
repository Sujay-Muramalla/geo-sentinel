#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/env.sh"

echo ""
echo "🌙 Geo-Sentinel EOD"

echo ""
echo "📦 Git status"
git status

echo ""
echo "💾 Suggested commit check"

git diff --stat

echo ""
echo "📋 Terraform plan snapshot"

"$GEO_ROOT/scripts/tf.sh" "$TF_ENV" plan

echo ""
echo "⚙ Generating automation helper"

cat <<EOF > "$GEO_ROOT/scripts/recreate-infra.sh"
#!/usr/bin/env bash

echo "Recreating Geo-Sentinel infrastructure"

./scripts/tf.sh $TF_ENV init
./scripts/tf.sh $TF_ENV apply
EOF

chmod +x "$GEO_ROOT/scripts/recreate-infra.sh"

echo ""
echo "✔ recreate-infra.sh generated"
