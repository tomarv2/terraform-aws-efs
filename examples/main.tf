terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 4.61"
    }
  }
}

provider "aws" {
  region = var.region
}

module "common" {
  source = "github.com/tomarv2/terraform-global.git//common?ref=v0.0.1"
}

module "efs" {
  source = "../"

  security_groups_to_use = [module.security_group.security_group_id]
  encrypted              = true

}

module "security_group" {
  source = "github.com/tomarv2/terraform-aws-security-group.git?ref=v0.0.10"

  security_group_ingress = {
    default = {
      description = "https"
      from_port   = 443
      protocol    = "tcp"
      to_port     = 443
      self        = true
      cidr_blocks = []
      type        = "ingress"
    },
    ssh = {
      description = "ssh"
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
      self        = false
      cidr_blocks = module.common.cidr_for_sec_grp_access
      type        = "ingress"
    }
  }

}
