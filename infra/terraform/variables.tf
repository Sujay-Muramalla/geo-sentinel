variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "eu-central-1"
}

variable "cloudtrail_log_retention_days" {
  description = "Number of days to retain CloudTrail logs before expiration"
  type        = number
  default     = 90
}

variable "athena_database_name" {
  description = "Athena database name for querying CloudTrail logs"
  type        = string
  default     = "geo_sentinel_cloudtrail"
}

variable "athena_table_name" {
  description = "Athena table name for CloudTrail logs"
  type        = string
  default     = "cloudtrail_logs"
}

variable "athena_results_prefix" {
  description = "S3 prefix for Athena query results"
  type        = string
  default     = "athena-results/"
}
