aws_region = "ap-south-1"

cluster_name = "assessment-eks"

vpc_name = "vpc-c"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

node_instance_type = "t3.medium"

desired_nodes = 4

min_nodes = 4

max_nodes = 4
