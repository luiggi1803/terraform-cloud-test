terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = "~> 1.15.0"
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = local.tags
  }

  access_key = var.use_floci ? "test" : var.aws_access_key
  secret_key = var.use_floci ? "test" : var.aws_secret_key

  skip_credentials_validation = var.use_floci
  skip_metadata_api_check     = var.use_floci
  skip_requesting_account_id  = var.use_floci
  s3_use_path_style           = var.use_floci

  dynamic "endpoints" {
    for_each = var.use_floci ? [1] : []
    content {
      s3  = var.floci_endpoint
      ec2 = var.floci_endpoint
      sts = var.floci_endpoint
    }
  }
}