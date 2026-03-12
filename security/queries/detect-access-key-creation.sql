SELECT r.eventTime,
       r.eventName,
       r.userIdentity.userName,
       r.sourceIPAddress
FROM cloudtrail_logs
CROSS JOIN UNNEST(Records) AS t(r)
WHERE r.eventName IN ('CreateAccessKey', 'UpdateAccessKey', 'DeleteAccessKey')
ORDER BY r.eventTime DESC;
