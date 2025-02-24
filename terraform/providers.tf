terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }
  }
}

provider "vault" {
  skip_tls_verify = true
  address         = local.vault_addr
  token           = var.vault_root_token
}

provider "aws" {
  region     = local.region
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key

  default_tags {
    tags = local.tags
  }
}

