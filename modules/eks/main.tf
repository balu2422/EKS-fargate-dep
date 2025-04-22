# Data sources to fetch EKS cluster details
data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}

# Configure Kubernetes provider with data from the created EKS cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
}

# EKS Cluster resource creation
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

# EKS Fargate Profile resource creation
resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = var.fargate_pod_role_arn
  subnet_ids             = var.fargate_subnet_ids

  selector {
    namespace = var.namespace
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

# Kubernetes Namespace resource creation
resource "kubernetes_namespace" "eks_namespace" {
  metadata {
    name = var.namespace
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

# Outputs
output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "fargate_profile_name" {
  value = aws_eks_fargate_profile.fargate_profile.fargate_profile_name
}

output "namespace_name" {
  value = kubernetes_namespace.eks_namespace.metadata[0].name
}
