output "bank_node_group_name" {
  description = "Bank API EKS node group name"
  value       = aws_eks_node_group.bank.node_group_name
}

output "bank_node_group_arn" {
  description = "Bank API EKS node group ARN"
  value       = aws_eks_node_group.bank.arn
}

output "upi_node_group_name" {
  description = "UPI API EKS node group name"
  value       = aws_eks_node_group.upi.node_group_name
}

output "upi_node_group_arn" {
  description = "UPI API EKS node group ARN"
  value       = aws_eks_node_group.upi.arn
}

output "node_role_arn" {
  description = "EKS worker node IAM role ARN"
  value       = aws_iam_role.node.arn
}