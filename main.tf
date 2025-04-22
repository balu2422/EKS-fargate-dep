
provider "kubernetes" {
  alias                  = "with_dependency"
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source                  = "./modules/vpc"
  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  az1                     = var.az1
  az2                     = var.az2
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
  cluster_name         = var.eks_cluster_name
  private_subnet_ids   = [module.vpc.private_subnet_az1_id, module.vpc.private_subnet_az2_id]
  fargate_subnet_ids   = [module.vpc.private_subnet_az1_id, module.vpc.private_subnet_az2_id]
  cluster_role_arn     = module.iam.cluster_role_arn
  fargate_pod_role_arn = module.iam.fargate_pod_role_arn
  fargate_profile_name = var.fargate_profile_name
  namespace            = var.eks_namespace
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "fargate_profile_name" {
  value = module.eks.fargate_profile_name
}

output "namespace" {
  value = module.eks.namespace_name
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
