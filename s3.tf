resource "aws_s3_bucket" "cerberus_bucket" {
  bucket = local.cerberus_bucket_name
}
