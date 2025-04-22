resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

#resource "kubernetes_namespace" "eks_ns" {
#  metadata {
#    name = var.namespace
# # }
#}


resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = var.fargate_pod_role_arn

  subnet_ids = var.fargate_subnet_ids  # ✅ FIXED from `subnets` to `subnet_ids`

  selector {
    namespace = var.namespace
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "fargate_profile_name" {
  value = aws_eks_fargate_profile.fargate_profile.fargate_profile_name
}

#output "namespace_name" {
## value = kubernetes_namespace.eks_ns.metadata[0].name
#}
