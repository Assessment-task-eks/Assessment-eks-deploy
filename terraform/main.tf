module "nodegroups" {
  source = "./nodegroups"

  cluster_name = module.eks.cluster_name

  # Bank API nodes:
  # subnet 0 + subnet 3
  # These should be in different Availability Zones.
  bank_subnet_ids = [
    module.vpc.private_subnet_ids[0],
    module.vpc.private_subnet_ids[3]
  ]

  # UPI API nodes:
  # subnet 1 + subnet 2
  # These should be in different Availability Zones.
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
