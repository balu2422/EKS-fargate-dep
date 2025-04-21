provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  az1                  = var.az1
  az2                  = var.az2
  public_subnet_az1_cidr  = var.public_subnet_az1_cidr
  public_subnet_az2_cidr  = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
}

module "iam" {
  source = "./modules/iam"
  name   = var.iam_role_name
}

module "eks" {
  source               = "./modules/eks"
  name                 = var.eks_cluster_name
  private_subnet_ids   = [module.vpc.private_subnet_az1_id, module.vpc.private_subnet_az2_id]
  fargate_subnet_ids   = [module.vpc.private_subnet_az1_id, module.vpc.private_subnet_az2_id]
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  fargate_pod_role_arn = module.iam.fargate_pod_role_arn
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_az1_id" {
  value = module.vpc.private_subnet_az1_id
}

output "private_subnet_az2_id" {
  value = module.vpc.private_subnet_az2_id
}

output "fargate_profile_name" {
  value = module.eks.fargate_profile_name
}
