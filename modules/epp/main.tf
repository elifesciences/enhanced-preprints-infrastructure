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


# This attachment is to a pre-existing group, not managed here.
resource "aws_iam_group_policy_attachment" "read_write_sources_production_attachment" {
  group      = var.production_team_group_name
  policy_arn = aws_iam_policy.read_write_sources.arn
}

resource "aws_iam_group_policy_attachment" "read_only_production_attachment" {
  group      = var.production_team_group_name
  policy_arn = aws_iam_policy.read_only.arn
}
