cluster_name = "assessment-eks"

vpc_name = "vpc-c"

vpc_cidr = "10.0.0.0/16"

# AZ-A, AZ-B, AZ-C, AZ-D -- index maps to node 1, 2, 3, 4
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

# index 0=node1(AZ-A) 1=node2(AZ-B) 2=node3(AZ-C) 3=node4(AZ-D)
# bank pair = [0,3] (nodes 1 & 4) / upi pair = [1,2] (nodes 2 & 3)
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

# Add IAM users/roles here that need EKS console/kubectl admin access
# in addition to whichever identity runs `terraform apply` in CI (iac already has access).
additional_admin_arns = [
  "arn:aws:iam::033142159665:root"
]

bank_api_repository = "bank-api"
upi_api_repository  = "upi-api"
