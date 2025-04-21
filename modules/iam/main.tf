resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })

  tags = {
    Name = "${var.name}-eks-cluster-role"
  }
}

resource "aws_iam_role" "fargate_pod_role" {
  name = "${var.name}-fargate-pod-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "eks-fargate.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })

  tags = {
    Name = "${var.name}-fargate-pod-role"
  }
}

resource "aws_iam_policy" "eks_cluster_policy" {
  name        = "${var.name}-eks-cluster-policy"
  description = "EKS Cluster policy for managing the cluster"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["eks:DescribeCluster", "eks:ListClusters"]
        Resource = "*"
        Effect   = "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = aws_iam_policy.eks_cluster_policy.arn
}

resource "aws_iam_role_policy_attachment" "fargate_pod_role_policy_attachment" {
  role       = aws_iam_role.fargate_pod_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "fargate_pod_role_arn" {
  value = aws_iam_role.fargate_pod_role.arn
}
