variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for EKS"
  type        = list(string)
}

variable "additional_admin_arns" {
  description = "Extra IAM principal ARNs (users/roles) to grant EKS cluster admin access, e.g. console users, alongside the Terraform runner"
  type        = list(string)
  default     = []
}