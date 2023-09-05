locals {
  project_name = "temporal"
  main_bucket_name = "elife-${local.project_name}-${var.env}-data"
  tags = {
    Project     = local.project_name
    Environment = var.env
  }
}

resource "aws_s3_bucket" "main_bucket" {
  bucket = local.main_bucket_name
  tags   = local.tags
}

resource "aws_iam_role" "temporal_role" {
  name = "elife-${local.project_name}-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action : "sts:AssumeRoleWithWebIdentity",
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${var.account_id}:oidc-provider/${var.irsa_oidc_provider}"
        },
        Condition : {
          StringEquals : {
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.temporal_irsa_namespace}:${var.temporal_irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_write" {
  name        = "elife-${local.project_name}-${var.env}-s3-read-write"
  path        = "/"
  description = "Temporal ${var.env} S3 bucket read/write access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid : "List",
        Effect : "Allow",
        Action : [
          "s3:ListBucket"
        ],
        Resource : [
          "${aws_s3_bucket.main_bucket.arn}",
        ]
      },
      {
        Sid : "AccessSubPaths",
        Effect : "Allow",
        Action : [
          "s3:DeleteObject",
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectAttributes",
          "s3:ListMultipartUploadParts",
          "s3:ListBucket",
          "s3:AbortMultipartUpload",
          "s3:ListBucketMultipartUploads"
        ],
        Resource : [
          "${aws_s3_bucket.main_bucket.arn}/*",
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "temporal_read_write_role_policy_attachment" {
  role       = aws_iam_role.temporal_role.name
  policy_arn = aws_iam_policy.read_write.arn
}
