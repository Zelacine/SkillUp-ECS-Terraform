# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region  = var.region
  profile = "default"
}

module "ecr"{
  source             = "./modules/ecr"
  create_ecr_repository   = true
  upload_docker_image     = true
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  public_subnet_tags = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
}

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}


# ACM certificate module
module "cert" {
  source = "./modules/cert"
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  zone_id                   = data.aws_route53_zone.main.zone_id
 
}


module "elb" {
  source             = "./modules/elb"
  name               = "my-flask-app"
  region            = var.region
  domain_name        = var.domain_name
  subdomain          = var.subdomain
  public_subnets     = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id
  security_groups    = [module.vpc.public_sg_id]
  #route53_zone_id   = data.aws_route53_zone.skillup_d888k_xyz.zone_id
  route53_zone_id    = data.aws_route53_zone.main.zone_id
  certificate_arn    = module.cert.certificate_arn
 
}

module "ecs" {
  source               = "./modules/ecs-v2"
  cluster_name         =  "my-flask-app"
  api_image            =  module.ecr.image_uri
  container_port       = 80
  container_env        = []
  task_cpu             = "256"
  task_memory          = "512"
  desired_count        = 1
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  lb_sg_id             = module.elb.lb_sg_id[0]
  lb_target_group_arn  = module.elb.default_target_group_arn

  #execution_role_arn    = aws_iam_role.ecs_execution.arn
  #task_role_arn         = aws_iam_role.ecs_task.arn

  # Automatically use your ECR repo
  #ecr_repo_url = data.aws_ecr_repository.app.repository_url

}
