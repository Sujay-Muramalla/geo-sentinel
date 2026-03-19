# Geo-Sentinel Athena Bootstrap

This directory contains the manual Athena bootstrap SQL required after Terraform-based infrastructure recreation.

## Why this exists

Terraform recreates the Athena infrastructure components such as:

- Athena database
- Athena workgroup
- Athena named query resources

However, the working CloudTrail external table used during validation was finalized manually in Athena using the `Records` array schema.

This SQL file preserves that working definition so the table can be recreated after BOD/EODT cycles.

## File

- `create-cloudtrail-table.sql`

## Post-BOD recovery steps

After running:

```bash
./scripts/bod.sh --apply

#notes
- Table definition captured from Athena using `SHOW CREATE TABLE cloudtrail_logs`
