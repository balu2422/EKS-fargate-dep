variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "az1" {
  description = "First Availability Zone"
  type        = string
}

variable "az2" {
  description = "Second Availability Zone"
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for the public subnet in AZ1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for the public subnet in AZ2"
  type        = string
}

variable "private_subnet_az1_cidr" {
  description = "CIDR block for the private subnet in AZ1"
  type        = string
}

variable "private_subnet_az2_cidr" {
  description = "CIDR block for the private subnet in AZ2"
  type        = string
}

variable "iam_role_name" {
  description = "Name for the IAM roles"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "fargate_profile_name" {
  description = "Fargate profile name"
  type        = string
}

variable "eks_namespace" {
  description = "Namespace for workloads on Fargate"
  type        = string
}
