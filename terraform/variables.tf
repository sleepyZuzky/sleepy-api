locals {
  region      = "mx-central-1"
  environment = "prod"
  creator     = "Terraform"
  team        = "Sleepy"
  entity      = "zuzki"
  vault_addr  = "https://vault.zuzki.dev"
  aws_account = "sleepy_zuzki"

  tags = {
    Environment = local.environment
    Creator     = local.creator
    Team        = local.team
    Entity      = local.entity
  }

  pub_subnets_cidr = {
    "${local.region}a" = "192.168.10.0/24"
    "${local.region}b" = "192.168.11.0/24"
  }

  priv_subnets_cidr = {
    "${local.region}a" = "192.168.20.0/24"
    "${local.region}b" = "192.168.21.0/24"
  }

  database = {
    name = "postgress"
    username = "user"
    password = "password"
  }

  repo = {
    owner = ""
    name = ""
    git_username = ""
    git_token = ""
  }
}

#-------------------------------------------------------------------------------
# VAULT DATA
#-------------------------------------------------------------------------------
variable "vault_root_token" {
  description = "Default Root Token to login in Vault instance"
}

# ------------------------------------------------------------------------------
# VPC
# ------------------------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "CIDR IP Block to be assigned in VPC"
  default     = "192.168.0.0/16"
}

variable "routing_table_cird_block" {
  description = "CIDR IP Block to be assigned in Routing Table"
  default     = "0.0.0.0/0"
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "public_key_path" {
  type      = string
  sensitive = true
}

variable "inbound_ports" {
  type = list(any)
}

variable "image_name" {
  type = string
}

variable "db_security_group_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "instance_security_group_name" {
  type = string
}

variable "project_root_path" {
  type = string
}

variable "terraform_root_path" {
  type = string

}

variable "git_username" {
  type = string
}

variable "git_token" {
  type = string
}

variable "owner" {
  type = string
}

variable "name" {
  type = string
}

variable "region" {
  type = string
}
