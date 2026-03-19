DROP TABLE IF EXISTS cloudtrail_logs;

CREATE EXTERNAL TABLE cloudtrail_logs (
  Records ARRAY<
    STRUCT<
      eventVersion:STRING,
      userIdentity:STRUCT<
        type:STRING,
        principalId:STRING,
        arn:STRING,
        accountId:STRING,
        userName:STRING
      >,
      eventTime:STRING,
      eventSource:STRING,
      eventName:STRING,
      awsRegion:STRING,
      sourceIPAddress:STRING,
      userAgent:STRING
    >
  >
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
LOCATION 's3://geo-sentinel-cloudtrail-logs-20260310204309124500000001/AWSLogs/632150488936/CloudTrail/';
