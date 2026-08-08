module "vpc" {
  source = "./vpc"

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}


module "eks" {
  source = "./eks"

  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.private_subnet_ids

  additional_admin_arns = var.additional_admin_arns

  depends_on = [
    module.vpc
  ]
}


module "nodegroups" {
  source = "./nodegroups"

  cluster_name = module.eks.cluster_name

  # Bank API
  # Private subnet 0 + private subnet 3
  bank_subnet_ids = [
    module.vpc.private_subnet_ids[0],
    module.vpc.private_subnet_ids[3]
  ]

  # UPI API
  # Private subnet 1 + private subnet 2
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