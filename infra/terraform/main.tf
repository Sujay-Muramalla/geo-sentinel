# Placeholder main file
# Resources will be added in later stories

module "vpc" {
  source = "./modules/vpc"

  name  = "geo-sentinel"
  cidr_block = "10.0.0.0/16"

  az_count = 2

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}
