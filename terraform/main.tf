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
}


# =========================================================
# EKS Node Group
# =========================================================

module "nodegroups" {
  source = "./nodegroups"

  cluster_name = module.eks.cluster_name

  subnet_ids = module.vpc.private_subnet_ids

  node_instance_type = var.node_instance_type
  desired_nodes      = var.desired_nodes
  min_nodes          = var.min_nodes
  max_nodes          = var.max_nodes

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
