terraform {
  backend "s3" {
    bucket = "ani4h-s3-backend"
    dynamodb_table = "ani4h-s3-backend"
    region = "ap-southeast-1"
    key = "ani4h"
    encrypt = false
  }
}

provider "aws" {
  region = "ap-southeast-1"
}


locals {
  project = "ani4h"
  az      = "ap-southeast-1a"
}

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {}

module "networking" {
  source = "./modules/networking"
  project          = local.project
  vpc_cidr         = "10.0.0.0/16"
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  database_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

module "broker" {
  source = "./modules/rabbitmq"
  project = local.project
  vpc     = module.networking.vpc
  sg      = module.networking.sg
  az = local.az
}

module "ecr" {
  source = "./modules/ecr"
  image_names =var.function_names
  project = local.project
}

module "lambdas" {
  depends_on = [module.ecr]
  source = "./modules/lambda"
  project = local.project
  region = data.aws_region.current.name
  function_names = var.function_names
  account_id = data.aws_caller_identity.current.account_id
}

module "database" {
  source = "./modules/database"
  project = local.project
  vpc     = module.networking.vpc
  sg      = module.networking.sg
  az = local.az
}
module "opensearch" {
  source = "./modules/opensearch"
  project = local.project
  az = local.az
  sg = module.networking.sg
  vpc = module.networking.vpc
}

module "vm" {
  source = "./modules/ec2"
  project = local.project
  vpc =module.networking.vpc
  sg = module.networking.sg
  az = local.az
  ecs_cluster = module.ecs.ecs
}

module "s3" {
  source = "./modules/s3"
  project = local.project
}

module "gateway" {
  source = "./modules/gateway"
  project = local.project
  vpc =module.networking.vpc
  sg = module.networking.sg
  az = local.az
  servicediscovery = module.ecs.servicediscovery
}

module "ecs" {
  source = "./modules/ecs"
  project = local.project
  vpc =module.networking.vpc
  sg = module.networking.sg
  az = local.az
  services = var.services
}
