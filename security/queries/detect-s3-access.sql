SELECT r.eventTime,
       r.eventName,
       r.eventSource,
       r.sourceIPAddress,
       r.userIdentity.userName
FROM cloudtrail_logs
CROSS JOIN UNNEST(Records) AS t(r)
WHERE r.eventSource = 's3.amazonaws.com'
ORDER BY r.eventTime DESC;
