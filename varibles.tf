variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "az1" {
  description = "First availability zone"
  type        = string
}

variable "az2" {
  description = "Second availability zone"
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for public subnet in AZ1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for public subnet in AZ2"
  type        = string
}

variable "private_subnet_az1_cidr" {
  description = "CIDR block for private subnet in AZ1"
  type        = string
}

variable "private_subnet_az2_cidr" {
  description = "CIDR block for private subnet in AZ2"
  type        = string
}

variable "iam_role_name" {
  description = "Base name for IAM roles (used in IAM module)"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS Cluster name"
  type        = string
}

variable "fargate_profile_name" {
  description = "Fargate profile name"
  type        = string
}

variable "eks_namespace" {
  description = "Namespace to deploy EKS workloads to"
  type        = string
}
