locals {
  project_name = "epp"
  main_bucket_name  = "${var.env}-elife-epp-data"
  meca_bucket_name  = "${var.env}-elife-epp-meca"
  pdf_bucket_name  = "${var.env}-elife-epp-pdf"
  tags = {
    Project     = local.project_name
    Environment = var.env
  }
}

resource "aws_s3_bucket" "main_bucket" {
  bucket = local.main_bucket_name
  tags   = local.tags
}

resource "aws_s3_bucket" "meca_bucket" {
  bucket = local.meca_bucket_name
  tags   = local.tags
}

resource "aws_s3_bucket" "pdf_bucket" {
  bucket = local.pdf_bucket_name
  tags   = local.tags
}
