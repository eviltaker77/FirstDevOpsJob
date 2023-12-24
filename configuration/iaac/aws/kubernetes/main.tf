# aws -- version 
# aws eks  --region us-east-1 update-kubeconfig --name aforo255-cluster
# Uses default VPC  and Subnet. Create Your Own VPC and Private Subnets for 
# terraform-backend-state-aforo255
#arn:aws:iam::532336934360:user/terraform-aws-user
terraform {
  backend "s3" {
    bucket = "mybucket" # Will be overridden from build
    key    = "path/to/my/key" # Will be overridden from build
    region = "us-east-1"
  }
}

resource "aws_default_vpc" "default" {

}

data "aws_subnet_ids" "subnets" {
  vpc_id = aws_default_vpc.default.id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
 // load_config_file       = false
 // version                = "~> 1.9"
}

module "aforo255-cluster6AV" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "aforo255-cluster6AV"
  cluster_version = "1.21"
  subnet_ids         = ["subnet-adfa07f2", "subnet-a3c23d82"]  #CHANGE # Donot choose subnet from us-east-1e
  #subnets = data.aws_subnet_ids.subnets.ids
  vpc_id          = aws_default_vpc.default.id
  #vpc_id         = "vpc-1234556abcdef" 



}

data "aws_eks_cluster" "cluster" {
  name = module.aforo255-cluster6AV.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.aforo255-cluster6AV.cluster_id
}


# We will use ServiceAccount to connect to K8S Cluster in CI/CD mode
# ServiceAccount needs permissions to create deployments 
# and services in default namespace
resource "kubernetes_cluster_role_binding" "example" {
  metadata {
    name = "fabric8-rbac"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "default"
  }
}

# Needed to set the default region
provider "aws" {
  region  = "us-east-1"
}

resource "aws_iam_role" "test_role_dev" {
  name = "test_role_dev"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
