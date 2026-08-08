provider "aws" {
  region = "us-east-1"
}


# =========================================================
# VPC
# =========================================================

module "vpc" {
  source = "./vpc"

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}



# =========================================================
# EKS Cluster
# =========================================================

module "eks" {
  source = "./eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnet_ids

  additional_admin_arns = var.additional_admin_arns
}

# =========================================================
# EKS Node Group
# =========================================================

module "nodegroups" {
  source = "./nodegroups"

  cluster_name = module.eks.cluster_name

  # Node pair 1 & 4: bank-api, spread across two different AZs
  bank_subnet_ids = [
    module.vpc.private_subnet_ids[0],
    module.vpc.private_subnet_ids[3]
  ]

  # Node pair 2 & 3: upi-api, spread across two different AZs
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


# =========================================================
# ECR
# =========================================================

module "ecr" {
  source = "./ecr"
}


# =========================================================
# Terraform Backend
# =========================================================

terraform {
  backend "s3" {
    bucket = "ram-test-eks"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}



