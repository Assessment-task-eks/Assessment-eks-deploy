
# =========================================================
# EKS Worker Node IAM Role (shared by both node groups)
# =========================================================

resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


# =========================================================
# EKS Worker Node Policy
# =========================================================

resource "aws_iam_role_policy_attachment" "worker" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}


# =========================================================
# AWS VPC CNI Policy
# =========================================================

resource "aws_iam_role_policy_attachment" "cni" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}


# =========================================================
# ECR Read Only Policy
# =========================================================

resource "aws_iam_role_policy_attachment" "registry" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# =========================================================
# SSM Policy
# =========================================================

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


# =========================================================
# NODE GROUP 1: "bank" pair
# Nodes 1 & 4 -- placed in two DIFFERENT AZs (subnet index
# 0 and 3) so bank-api survives a single-AZ failure.
# Labeled workload=bank to satisfy bank-api's nodeAffinity.
# =========================================================

resource "aws_eks_node_group" "bank" {
  cluster_name    = var.cluster_name
  node_group_name = "bank-workers"

  node_role_arn = aws_iam_role.node.arn

  subnet_ids = var.bank_subnet_ids

  instance_types = [
    var.node_instance_type
  ]

  capacity_type = "ON_DEMAND"

  # Amazon Linux 2023
  # Required for EKS versions newer than Kubernetes 1.32
  ami_type = "AL2023_x86_64_STANDARD"

  scaling_config {
    desired_size = var.desired_nodes_per_group
    min_size     = var.min_nodes_per_group
    max_size     = var.max_nodes_per_group
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    workload = "bank"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.registry,
    aws_iam_role_policy_attachment.ssm
  ]

  tags = {
    Name = "bank-workers"
  }
}


# =========================================================
# NODE GROUP 2: "upi" pair
# Nodes 2 & 3 -- placed in two DIFFERENT AZs (subnet index
# 1 and 2) so upi-api survives a single-AZ failure.
# Labeled workload=upi to satisfy upi-api's nodeAffinity.
# =========================================================

resource "aws_eks_node_group" "upi" {
  cluster_name    = var.cluster_name
  node_group_name = "upi-workers"

  node_role_arn = aws_iam_role.node.arn

  subnet_ids = var.upi_subnet_ids

  instance_types = [
    var.node_instance_type
  ]

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  scaling_config {
    desired_size = var.desired_nodes_per_group
    min_size     = var.min_nodes_per_group
    max_size     = var.max_nodes_per_group
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    workload = "upi"
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.registry,
    aws_iam_role_policy_attachment.ssm
  ]

  tags = {
    Name = "upi-workers"
  }
}
