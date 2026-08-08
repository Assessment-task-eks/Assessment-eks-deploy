output "node_group_name" { 
  description = "EKS Node Group Name" 
  value = aws_eks_node_group.nodes.node_group_name 
  
  } 


output "node_role_arn" { 
  
description = "EKS Worker Node IAM Role ARN"
value = aws_iam_role.node.arn 
}