module "vpc" {
  source = "./vpc"

  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}


module "eks" {
  source = "./eks"

  cluster_name = var.cluster_name

  subnet_ids = module.vpc.private_subnet_ids

  depends_on = [
    module.vpc
  ]
}


module "nodegroups" {
  source = "./nodegroups"

  cluster_name = module.eks.cluster_name

  # Bank API nodes
  # subnet 0 + subnet 3
  # Different Availability Zones

  bank_subnet_ids = [
    module.vpc.private_subnet_ids[0],
    module.vpc.private_subnet_ids[3]
  ]

  # UPI API nodes
  # subnet 1 + subnet 2
  # Different Availability Zones

  upi_subnet_ids = [
    module.vpc.private_subnet_ids[1],
    module.vpc.private_subnet_ids[2]
  ]

  node_instance_type      = var.node_instance_type
  desired_nodes_per_group = var.desired_nodes_per_group
  min_nodes_per_group     = var.min_nodes_per_group
  max_nodes_per_group     = var.max_nodes_per_group

  depends_on = [
    module.eks
  ]
}


module "ecr" {
  source = "./ecr"

  bank_api_repository = var.bank_api_repository
  upi_api_repository  = var.upi_api_repository
}