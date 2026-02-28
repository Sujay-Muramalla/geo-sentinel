#!/bin/bash
set -e

echo "🚀 Setting up Geo-Sentinel project structure..."

# Create base folders
mkdir -p frontend backend-api sentiment-service infra scripts docs .github/workflows

# Create .gitignore
cat > .gitignore <<'EOF'
# ---- OS ----
.DS_Store
Thumbs.db

# ---- Logs ----
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# ---- Node ----
node_modules/
dist/
build/
.cache/
.vite/
.next/
out/

# ---- Python ----
__pycache__/
*.py[cod]
*.pyo
*.pyd
.venv/
venv/
ENV/
env/
.pytest_cache/
.mypy_cache/

# ---- Terraform ----
**/.terraform/*
*.tfstate
*.tfstate.*
crash.log
*.tfvars
override.tf
override.tf.json
*_override.tf
*_override.tf.json
.terraform.lock.hcl

# ---- Secrets / env ----
.env
.env.*
!.env.example

# ---- IDE ----
.vscode/
.idea/
EOF

# Create editorconfig
cat > .editorconfig <<'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true

[*.py]
indent_size = 4

[Makefile]
indent_style = tab
EOF

# Create example env
cat > .env.example <<'EOF'
API_PORT=4000
SENTIMENT_PORT=8000
AWS_REGION=eu-central-1
EOF

# Create README
cat > README.md <<'EOF'
# Geo-Sentinel

Geo-Sentinel is a geopolitics-focused news aggregation and sentiment intelligence platform.

Prototype UI style: cyberpunk hacker console.
Later evolves into enterprise intelligence platform.

Monorepo structure:
- frontend/
- backend-api/
- sentiment-service/
- infra/
- scripts/
- docs/
EOF

echo "✅ Setup complete."