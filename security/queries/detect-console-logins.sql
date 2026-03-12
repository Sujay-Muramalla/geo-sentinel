SELECT r.eventTime,
       r.eventName,
       r.sourceIPAddress,
       r.userIdentity.userName,
       r.userIdentity.type
FROM cloudtrail_logs
CROSS JOIN UNNEST(Records) AS t(r)
WHERE r.eventName = 'ConsoleLogin'
ORDER BY r.eventTime DESC;
