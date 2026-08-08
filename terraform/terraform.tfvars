cluster_name = "assessment-eks"

vpc_name = "vpc-c"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
  "us-east-1d"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.11.0/24",
  "10.0.12.0/24",
  "10.0.13.0/24",
  "10.0.14.0/24"
]

node_instance_type = "t3.medium"

desired_nodes_per_group = 2

min_nodes_per_group = 2

max_nodes_per_group = 2

additional_admin_arns = [
  "arn:aws:iam::033142159665:root"
]

bank_api_repository = "bank-api"

upi_api_repository = "upi-api"