#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/env.sh"

echo ""
echo "🌙 Geo-Sentinel EODT (Terminate Infra)"

read -p "Destroy Terraform infrastructure? (yes/no): " confirm

if [[ "$confirm" != "yes" ]]; then
  echo "Abort."
  exit 0
fi

"$GEO_ROOT/scripts/tf.sh" "$TF_ENV" destroy

echo ""
echo "💰 Infrastructure destroyed to save cost"

echo ""
echo "🧠 Next step: generate architecture diagram prompt"

cat <<EOF

Prompt for AI AWS Diagram Generator:

Create an AWS architecture diagram for project "Geo-Sentinel".

Infrastructure includes:

Region: eu-central-1

VPC CIDR: 10.0.0.0/16

Public Subnets:
10.0.1.0/24
10.0.2.0/24

Private Subnets:
10.0.101.0/24
10.0.102.0/24

Components:
Internet Gateway
Public Route Table
Private Route Table
S3 Gateway Endpoint
Public Security Group (80/443)
Private Security Group (port 3000 from public tier)

Application architecture:
Frontend
Backend API
Sentiment service

Environment: dev

EOF
