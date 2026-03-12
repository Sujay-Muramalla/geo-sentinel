SELECT r.eventTime,
       r.eventName,
       r.eventSource,
       r.userIdentity.userName,
       r.sourceIPAddress
FROM cloudtrail_logs
CROSS JOIN UNNEST(Records) AS t(r)
WHERE r.eventSource = 'iam.amazonaws.com'
ORDER BY r.eventTime DESC;
