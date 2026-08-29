terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"

  region              = var.region
  admin_cidr          = var.admin_cidr
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "compute" {
  source = "./modules/compute"

  ami_id                = var.ami_id
  instance_type         = var.instance_type
  web_count             = var.web_count
  key_name              = var.key_name
  public_subnet_id      = module.network.public_subnet_id
  private_subnet_id     = module.network.private_subnet_id
  web_security_group_id = module.network.web_security_group_id
  db_security_group_id  = module.network.db_security_group_id
}