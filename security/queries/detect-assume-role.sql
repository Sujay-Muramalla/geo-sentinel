SELECT r.eventTime,
       r.eventName,
       r.eventSource,
       r.sourceIPAddress,
       r.userIdentity.arn
FROM cloudtrail_logs
CROSS JOIN UNNEST(Records) AS t(r)
WHERE r.eventName = 'AssumeRole'
ORDER BY r.eventTime DESC;
