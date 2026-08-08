variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for EKS"
  type        = list(string)
}

variable "additional_admin_arns" {
  description = "Additional IAM principals that require EKS administrator access"
  type        = list(string)
  default     = []
}