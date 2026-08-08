variable "desired_nodes_per_group" {
  description = "Desired number of nodes in each EKS node group"
  type        = number
}

variable "min_nodes_per_group" {
  description = "Minimum number of nodes in each EKS node group"
  type        = number
}

variable "max_nodes_per_group" {
  description = "Maximum number of nodes in each EKS node group"
  type        = number
}
