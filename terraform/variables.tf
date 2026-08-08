variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EKS worker node instance type"
  type        = string
}

variable "desired_nodes_per_group" {
  description = "Desired number of nodes per node group"
  type        = number
}

variable "min_nodes_per_group" {
  description = "Minimum number of nodes per node group"
  type        = number
}

variable "max_nodes_per_group" {
  description = "Maximum number of nodes per node group"
  type        = number
}

variable "bank_api_repository" {
  description = "Bank API ECR repository"
  type        = string
  default     = "bank-api"
}

variable "upi_api_repository" {
  description = "UPI API ECR repository"
  type        = string
  default     = "upi-api"
}