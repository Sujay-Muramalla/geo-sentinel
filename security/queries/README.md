# Geo-Sentinel CloudTrail Detection Queries

This directory contains Athena SQL queries for detecting security-relevant AWS activity from CloudTrail logs.

## Query Set

- detect-root-usage.sql
- detect-console-logins.sql
- detect-iam-changes.sql
- detect-access-key-creation.sql
- detect-assume-role.sql
- detect-s3-access.sql

## Usage

Run these queries in Athena against the `geo_sentinel_cloudtrail` database using the `cloudtrail_logs` table.

All queries assume the CloudTrail Athena table uses the `Records` array schema and events are extracted using:

```sql
CROSS JOIN UNNEST(Records) AS t(r)
```
