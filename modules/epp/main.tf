locals {
  project_name = "epp"
  bucket_name  = "${var.env}-elife-epp-data"
  tags = {
    Project     = local.project_name
    Environment = var.env
  }
}

resource "aws_s3_bucket" "main_bucket" {
  bucket = local.bucket_name
  tags   = local.tags
}
