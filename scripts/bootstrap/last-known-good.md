# Geo-Sentinel — Last Known Good (EOD Snapshot)

- Date (local): Thu Mar  5 13:58:57 CET 2026
- Git branch: chore/eod-snapshot-correctness
- Git commit: 47fc74ae0b879df2f8531759b90cc02b718d9266
- Git short:  47fc74a

## Environment
- TF_ENV: dev
- AWS_PROFILE: default
- AWS_REGION: eu-central-1

## Terraform
- Terraform: Terraform v1.14.6
- AWS CLI: aws-cli/2.31.38 Python/3.13.9 Darwin/25.3.0 source/arm64

## Terraform Outputs (if infra exists)
```
private_route_table_id = "rtb-03cdf6d55e35b0299"
private_sg_id = "sg-032fbc051602bfc5e"
private_subnet_ids = [
  "subnet-03936ab39503d7762",
  "subnet-0b963b21573343967",
]
public_route_table_id = "rtb-0d6ef0a416520075b"
public_sg_id = "sg-0541743d172bb84ae"
public_subnet_ids = [
  "subnet-01b6c384629ceadbf",
  "subnet-0e3541b5376c1c9c0",
]
vpc_id = "vpc-041734561215d0fed"
```

## State Sync Reminder (LOCAL STATE MODE)
If switching machines before next Terraform run, sync:
- infra/terraform/terraform.tfstate
- infra/terraform/terraform.tfstate.backup (if present)
- infra/terraform/.terraform.lock.hcl
