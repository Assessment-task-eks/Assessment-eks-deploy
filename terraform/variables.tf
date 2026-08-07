variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}


variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "desired_nodes" {
  description = "Desired Worker Nodes"
  type        = number
}

variable "min_nodes" {
  description = "Minimum Worker Nodes"
  type        = number
}

variable "max_nodes" {
  description = "Maximum Worker Nodes"
  type        = number
}
