variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_role_arn" {
  description = "EKS cluster role ARN"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "fargate_profile_name" {
  description = "EKS Fargate profile name"
  type        = string
}

variable "fargate_subnet_ids" {
  description = "Subnets for Fargate profile"
  type        = list(string)
}

variable "fargate_pod_role_arn" {
  description = "Fargate Pod execution role ARN"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for Fargate workloads"
  type        = string
}
