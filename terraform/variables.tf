variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}


variable "vpc_name" {
  description = "VPC name"
  type        = string
}


variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}


variable "availability_zones" {
  description = "Availability zones for the VPC"
  type        = list(string)
}


variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}


variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}


variable "node_instance_type" {
  description = "EKS worker node instance type"
  type        = string
}


variable "desired_nodes_per_group" {
  description = "Desired number of nodes in each node group"
  type        = number
}


variable "min_nodes_per_group" {
  description = "Minimum number of nodes in each node group"
  type        = number
}


variable "max_nodes_per_group" {
  description = "Maximum number of nodes in each node group"
  type        = number
}


variable "bank_api_repository" {
  description = "ECR repository name for Bank API"
  type        = string
  default     = "bank-api"
}


variable "upi_api_repository" {
  description = "ECR repository name for UPI API"
  type        = string
  default     = "upi-api"
}


variable "additional_admin_arns" {
  description = "Additional IAM principals that require EKS administrator access"
  type        = list(string)
  default     = []
}