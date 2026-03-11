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
