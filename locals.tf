locals {
  region_prefixes = {
    "us-east-1" = "UE1"
    "us-east-2" = "UE2"
  }

  environment_codes = {
    dev  = "DESA"
    test = "TEST"
    prod = "PROD"
  }

  tags = {
    Environment = local.environment_code
    region      = var.aws_region
    owner       = "Luiggi Huaman"
    cloud       = "AWS"
    iac         = "Terraform"
    iac_version = "1.15.4"
    project     = "cerberus"
  }
  region_prefix    = local.region_prefixes[var.aws_region]
  environment_code = local.environment_codes[var.environment]
  deployment_stage = local.environment_codes[var.environment]

  cerberus_bucket_name = "${local.tags.project}-${random_string.subfijo_s3.id}"
}

resource "random_string" "subfijo_s3" {
  length  = 8
  special = false
  upper   = false
}
