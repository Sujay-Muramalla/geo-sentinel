# Geo-Sentinel — Last Known Good (EOD Snapshot)

- Date (local): Thu Mar  5 13:40:24 CET 2026
- Git branch: chore/scripts-eod-recreate-snapshot
- Git commit: 512d091f4965be0190e758320ee840019e723e68
- Git short:  512d091

## Environment
- TF_ENV: dev
- AWS_PROFILE: default
- AWS_REGION: eu-central-1

## Terraform
- Terraform: Terraform v1.14.6
- AWS CLI: aws-cli/2.31.38 Python/3.13.9 Darwin/25.3.0 source/arm64

## Terraform Outputs (if infra exists)
```
private_route_table_id = "rtb-00ae021735df31969"
private_sg_id = "sg-08de5b6e825eafb86"
private_subnet_ids = [
  "subnet-0a111494d205fdcb4",
  "subnet-0d947a4dc6b67db9e",
]
public_route_table_id = "rtb-0ed9cbd0244ce11fa"
public_sg_id = "sg-053fdb7143c830a08"
public_subnet_ids = [
  "subnet-07d28efb5cb74077c",
  "subnet-092bc2416ceea5bb0",
]
vpc_id = "vpc-058f022cde386b4d1"
```

## State Sync Reminder (LOCAL STATE MODE)
If switching machines before next Terraform run, sync:
- infra/terraform/terraform.tfstate
- infra/terraform/terraform.tfstate.backup (if present)
- infra/terraform/.terraform.lock.hcl
