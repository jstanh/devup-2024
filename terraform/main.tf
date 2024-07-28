terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "my_aws_cli_profile"
}

module "alb" {
  source = "./modules/alb"

  vpc_id = module.vpc.vpc_id
  first_subnet_id = module.vpc.first_subnet_id
  second_subnet_id = module.vpc.second_subnet_id
  load_balancer_name = "lb-development"
  target_group_name = "tg-development"
  api_domain_name = "development.example.com"
  load-balancer-security-group-id = module.iam.sg_load_balancer_id
}

module "cloudfront" {
  source = "./modules/cloudfront"

  client_site_name = "com.stanhouse.devsite"
  client_bucket_domain_name = module.s3.client_bucket_domain_name
}

module "code" {
  source = "./modules/code"
  cluster_name = module.ecs.cluster_name
  service_name = module.ecs.service_name
  code_pipeline_name = "dev-pipeline"
  build_project_name = "dev-build"
  repository_name = "dev-repository"
  codebuild_role_arn = module.iam.role_codebuild_arn
  codepipeline_role_arn = module.iam.role_codepipeline_arn
  codebuild_bucket_id = module.s3.codebuild_bucket_id
}

module "ec2" {
  source = "./modules/ec2"

  aws_region = var.aws_region 
  ECS_instance_size = "m5.large" 
  first_subnet_id = module.vpc.first_subnet_id 
  second_subnet_id = module.vpc.second_subnet_id
  sg_ecs_cluster_instance_id = module.iam.sg_ecs_cluster_instance_id
  ecs_instance_role_name = module.iam.role_ecs_instance_name
  ecs_cluster_name = module.ecs.cluster_name
}


module "ecs" {
  source = "./modules/ecs"

  task_definition_family = "development-api" 
  ecr_repository_name = "development-api-repo" 
  ecs_service_name = "development-service" 
  target_group_arn = module.alb.target_group_arn 
  ecs_instance_role_name = module.iam.role_ecs_instance_name
  ecs_task_execution_role_arn = module.iam.role_ecs_task_execution_arn
  cluster_name = "development-cluster"
}

module "iam" {
  source = "./modules/iam"

  vpc_id = module.vpc.vpc_id
}

module "s3" {
  source = "./modules/s3"

  client_site_name = "com.terraform-sitename.devsite"
  client_cloudfront_arn = module.cloudfront.cloudfront_client_arn
}

module "vpc" {
  source = "./modules/vpc"

  nacl_name = "development-nacl"
  aws_region = var.aws_region
  vpc_name = "development"
  gateway_name = "development-gateway"
  route_table_name = "development-routes"
  subnet_name = "development-subnet"
}


