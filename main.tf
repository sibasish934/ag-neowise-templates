module "vpc" {
  source           = "./network"
  vpc_cidr         = var.vpc_cidr
  prefix           = local.prefix
  common_tags      = local.common_tags
  environment      = var.env
  subnet_cidr_list = var.subnet_cidr_list
}

module "security-group" {
  source      = "./security"
  prefix      = local.prefix
  env         = var.env
  vpc_cidr    = var.vpc_cidr
  common_tags = local.common_tags
  vpc_id      = module.vpc.vpc_id
}

module "database" {
  source             = "./database"
  prefix             = local.prefix
  rds_sg_id          = module.security-group.rds_sg_id
  private_subnet_id  = module.vpc.private_subnet_id
  private_subnet_ids = module.vpc.private_subnets
  common_tags        = local.common_tags
}

module "server" {
  source            = "./server"
  prefix            = local.prefix
  common_tags       = local.common_tags
  private_subnet_id = module.vpc.private_subnet_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_sg_id     = module.security-group.private_sg_id
  public_sg_id      = module.security-group.public_sg_id
  ami               = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  ssh_key_name      = var.ssh_key_name
}

module "amazon_mq" {
  source              = "./amazon-mq-module"
  name                = "feature-app-mq-prod-cluster"
  engine_version      = "4.2"
  instance_type       = "mq.m7g.large"
  engine_type         = "RabbitMQ"
  deployment_mode     = "CLUSTER_MULTI_AZ"
  subnet_ids          = module.vpc.private_subnets
  vpc_id              = module.vpc.vpc_id
  username            = var.username
  password            = var.password
  allowed_cidr_blocks = ["10.10.0.0/16"]
  tags = merge(
    local.common_tags,
    tomap(
      {
        "Name" = "${var.prefix}-mq"
    })
  )
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.9.0"

  name               = "neowise-app-cluster-${var.env}"
  kubernetes_version = "1.34"

  endpoint_public_access                   = false
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 3
      max_size     = 5
      desired_size = 3

      instance_types = ["m5.xlarge"]
    }
  }

  tags = merge(
    local.common_tags,
    tomap(
      {
        "Name" = "${var.prefix}-eks"
    })
  )
}





