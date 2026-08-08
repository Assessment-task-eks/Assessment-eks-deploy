variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
}

variable "desired_nodes" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "min_nodes" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "max_nodes" {
  description = "Maximum number of worker nodes"
  type        = number
}

