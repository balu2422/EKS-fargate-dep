resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    endpoint_private_access = false
    endpoint_public_access  = true
  }

  depends_on = [var.eks_cluster_role_dependencies]
}

resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = "fargate-profile"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = var.namespace
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "kubernetes_namespace" "eks_namespace" {
  metadata {
    name = var.namespace
  }

  depends_on = [aws_eks_fargate_profile.fargate_profile]
}

resource "null_resource" "wait_for_eks" {
  provisioner "local-exec" {
    command = "echo Waiting for EKS cluster..."
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "kubernetes_config_map" "aws_auth" {
  provider = kubernetes.with_dependency

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::557548602903:user/devops-b"
        username = "devops-b"
        groups   = ["system:masters"]
      }
    ])
  }

  depends_on = [null_resource.wait_for_eks]
}
