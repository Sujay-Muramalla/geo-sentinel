
### `security/queries/detect-root-usage.sql`

```sql
SELECT r.eventTime,
       r.eventSource,
       r.eventName,
       r.sourceIPAddress,
       r.userIdentity.arn
FROM cloudtrail_logs
CROSS JOIN UNNEST(Records) AS t(r)
WHERE r.userIdentity.type = 'Root'
ORDER BY r.eventTime DESC;
