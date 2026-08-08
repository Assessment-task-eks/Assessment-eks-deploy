
# =========================================================
# EKS Worker Node IAM Role
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
# EKS Managed Node Group
# =========================================================

resource "aws_eks_node_group" "nodes" {
  cluster_name    = var.cluster_name
  node_group_name = "application-workers"

  node_role_arn = aws_iam_role.node.arn

  subnet_ids = var.subnet_ids

  instance_types = [
    var.node_instance_type
  ]

  capacity_type = "ON_DEMAND"

  # Amazon Linux 2023
  # Required for EKS versions newer than Kubernetes 1.32
  ami_type = "AL2023_x86_64_STANDARD"

  scaling_config {
    desired_size = var.desired_nodes
    min_size     = var.min_nodes
    max_size     = var.max_nodes
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.registry,
    aws_iam_role_policy_attachment.ssm
  ]

  tags = {
    Name = "application-workers"
  }
}
