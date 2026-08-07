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



resource "aws_iam_role_policy_attachment" "worker" {

  role = aws_iam_role.node.name

  policy_arn =
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}


resource "aws_iam_role_policy_attachment" "cni" {

  role = aws_iam_role.node.name

  policy_arn =
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}


resource "aws_iam_role_policy_attachment" "registry" {

  role = aws_iam_role.node.name

  policy_arn =
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}



resource "aws_eks_node_group" "nodes" {

  cluster_name = var.cluster_name

  node_group_name = "application-workers"


  node_role_arn = aws_iam_role.node.arn


  subnet_ids = var.subnet_ids


  scaling_config {

    desired_size = var.desired_nodes

    max_size = var.max_nodes

    min_size = var.min_nodes

  }


  instance_types = [
    var.node_instance_type
  ]


  depends_on = [

    aws_iam_role_policy_attachment.worker,

    aws_iam_role_policy_attachment.cni,

    aws_iam_role_policy_attachment.registry

  ]

}
