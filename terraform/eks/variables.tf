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
