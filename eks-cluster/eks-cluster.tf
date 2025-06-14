module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  subnet_ids = local.private_subnets
  vpc_id     = local.vpc_id

  enable_irsa = true

  cluster_addons = {
    coredns = { most_recent = true },
    kube-proxy = { most_recent = true },
    vpc-cni = { most_recent = true },
    ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_irsa.iam_role_arn
    },
    efs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.efs_irsa.iam_role_arn
    },
    metrics-server = { most_recent = true }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = [var.node_instance_type]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      subnet_ids     = local.private_subnets
    }
  }
}
