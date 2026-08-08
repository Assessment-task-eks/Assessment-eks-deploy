output "node_role_arn" {
  description = "EKS Worker Node IAM Role ARN"
  value       = aws_iam_role.node.arn
}

output "node_role_name" {
  description = "EKS Worker Node IAM Role Name"
  value       = aws_iam_role.node.name
}

output "bank_node_group_name" {
  description = "Bank API EKS Node Group Name"
  value       = aws_eks_node_group.bank.node_group_name
}

output "upi_node_group_name" {
  description = "UPI API EKS Node Group Name"
  value       = aws_eks_node_group.upi.node_group_name
}

output "bank_node_group_arn" {
  description = "Bank API EKS Node Group ARN"
  value       = aws_eks_node_group.bank.resources[0].remote_access_security_group_id
}

output "upi_node_group_arn" {
  description = "UPI API EKS Node Group ARN"
  value       = aws_eks_node_group.upi.arn
}