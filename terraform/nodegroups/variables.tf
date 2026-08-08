variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "bank_subnet_ids" {
  description = "Private subnet IDs for Bank API node group"
  type        = list(string)

  validation {
    condition     = length(var.bank_subnet_ids) == 2
    error_message = "bank_subnet_ids must contain exactly 2 subnet IDs."
  }
}

variable "upi_subnet_ids" {
  description = "Private subnet IDs for UPI API node group"
  type        = list(string)

  validation {
    condition     = length(var.upi_subnet_ids) == 2
    error_message = "upi_subnet_ids must contain exactly 2 subnet IDs."
  }
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
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

