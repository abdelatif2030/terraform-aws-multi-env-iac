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

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  enable_nat_gateway   = var.enable_nat_gateway
  common_tags          = local.common_tags
}

module "security_groups" {
  source = "../../modules/security-groups"

  environment      = var.environment
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
  common_tags      = local.common_tags
}

module "ec2" {
  source = "../../modules/ec2"

  environment                = var.environment
  instance_count             = var.instance_count
  instance_type              = var.instance_type
  subnet_ids                 = module.vpc.public_subnet_ids
  security_group_ids         = [module.security_groups.web_sg_id]
  public_key                 = var.ssh_public_key
  root_volume_size           = var.root_volume_size
  create_eip                 = var.create_eip
  enable_detailed_monitoring = var.enable_detailed_monitoring
  common_tags                = local.common_tags

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Development Environment - $(hostname -f)</h1>" > /var/www/html/index.html
              EOF
}
