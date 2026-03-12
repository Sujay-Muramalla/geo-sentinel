output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "public_sg_id" {
  value = module.vpc.public_sg_id
}

output "private_sg_id" {
  value = module.vpc.private_sg_id
}

output "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  value       = aws_cloudtrail.geo_sentinel_trail.name
}

output "cloudtrail_bucket" {
  description = "S3 bucket used for CloudTrail logs"
  value       = aws_s3_bucket.cloudtrail_logs.bucket
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = aws_cloudtrail.geo_sentinel_trail.arn
}

output "cloudtrail_bucket_arn" {
  description = "ARN of the CloudTrail log bucket"
  value       = aws_s3_bucket.cloudtrail_logs.arn
}

output "athena_database_name" {
  description = "Athena database for CloudTrail log analysis"
  value       = aws_athena_database.cloudtrail.name
}

output "athena_workgroup_name" {
  description = "Athena workgroup for CloudTrail log analysis"
  value       = aws_athena_workgroup.cloudtrail.name
}

output "athena_results_location" {
  description = "S3 location for Athena query results"
  value       = local.athena_results_location
}

output "cloudtrail_athena_table_location" {
  description = "S3 location of CloudTrail logs queried by Athena"
  value       = local.cloudtrail_athena_table_location
}
