variable "name" {
  description = "Name prefix for VPC resources"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "az_count" {
  description = "Number of availability zones"
  type        = number
  default     = 2
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "enable_s3_endpoint" {
  description = "Whether to create an S3 Gateway VPC endpoint"
  type        = bool
  default     = true
}
