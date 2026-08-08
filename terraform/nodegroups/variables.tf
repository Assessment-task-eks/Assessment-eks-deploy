
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "bank_subnet_ids" {
  description = "Private subnet IDs for Bank API nodes"
  type        = list(string)
}

variable "upi_subnet_ids" {
  description = "Private subnet IDs for UPI API nodes"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "desired_nodes_per_group" {
  description = "Desired number of nodes in each node group"
  type        = number
  default     = 2
}

variable "min_nodes_per_group" {
  description = "Minimum number of nodes in each node group"
  type        = number
  default     = 2
}

variable "max_nodes_per_group" {
  description = "Maximum number of nodes in each node group"
  type        = number
  default     = 2
}