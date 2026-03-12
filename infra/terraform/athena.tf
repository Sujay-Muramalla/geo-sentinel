locals {
  cloudtrail_athena_table_location = "s3://${aws_s3_bucket.cloudtrail_logs.bucket}/AWSLogs/${data.aws_caller_identity.current.account_id}/CloudTrail/"
  athena_results_location          = "s3://${aws_s3_bucket.cloudtrail_logs.bucket}/${var.athena_results_prefix}"
}


resource "aws_athena_database" "cloudtrail" {
  name   = var.athena_database_name
  bucket = aws_s3_bucket.cloudtrail_logs.bucket

  force_destroy = true
}

resource "aws_athena_workgroup" "cloudtrail" {
  name = "geo-sentinel-cloudtrail-wg"

  configuration {
    enforce_workgroup_configuration    = false
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = local.athena_results_location
    }
  }

  force_destroy = true
}

resource "aws_athena_named_query" "create_cloudtrail_table" {
  name        = "create-cloudtrail-table"
  database    = aws_athena_database.cloudtrail.name
  workgroup   = aws_athena_workgroup.cloudtrail.name
  description = "Creates external Athena table for CloudTrail logs"

  query = <<EOF
CREATE EXTERNAL TABLE IF NOT EXISTS ${var.athena_table_name} (
  eventversion STRING,
  useridentity STRUCT<
    type:STRING,
    principalid:STRING,
    arn:STRING,
    accountid:STRING,
    invokedby:STRING,
    accesskeyid:STRING,
    userName:STRING,
    sessioncontext:STRUCT<
      attributes:STRUCT<
        mfaauthenticated:STRING,
        creationdate:STRING>,
      sessionissuer:STRUCT<
        type:STRING,
        principalid:STRING,
        arn:STRING,
        accountid:STRING,
        userName:STRING>>>,
  eventtime STRING,
  eventsource STRING,
  eventname STRING,
  awsregion STRING,
  sourceipaddress STRING,
  useragent STRING,
  errorcode STRING,
  errormessage STRING,
  requestparameters STRING,
  responseelements STRING,
  additionaleventdata STRING,
  requestid STRING,
  eventid STRING,
  readonly STRING,
  resources ARRAY<STRUCT<
    arn:STRING,
    accountid:STRING,
    type:STRING>>,
  eventtype STRING,
  apiversion STRING,
  recipientaccountid STRING,
  serviceeventdetails STRING,
  sharedeventid STRING,
  vpcendpointid STRING,
  tlsdetails STRUCT<
    tlsversion:STRING,
    ciphersuite:STRING,
    clientprovidedhostheader:STRING>
)
PARTITIONED BY (`region` STRING, `year` STRING, `month` STRING, `day` STRING)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS INPUTFORMAT 'com.amazon.emr.cloudtrail.CloudTrailInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION '${local.cloudtrail_athena_table_location}';
EOF
}
