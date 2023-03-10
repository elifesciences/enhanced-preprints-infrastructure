locals {
  project_name = "epp"
  bucket_name = "${var.env}-elife-epp-data"
  tags = {
    Project     = local.project_name
    Environment = var.env
  }
}

resource "aws_s3_bucket" "main_bucket" {
  bucket  = local.bucket_name
  tags    = local.tags
}

moved {
  from = aws_s3_bucket.b
  to   = aws_s3_bucket.main_bucket
}

resource "aws_iam_policy" "read_write" {
  name        = "epp-${var.env}-s3-read-write"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read/write access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid: "List",
        Effect: "Allow",
        Action: [
          "s3:ListBucket"
        ],
        Resource: "arn:aws:s3:::${local.bucket_name}"
      },
      {
        Sid: "AccessSubPaths",
        Effect: "Allow",
        Action: [
          "s3:DeleteObject",
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectAttributes",
          "s3:ListMultipartUploadParts",
          "s3:ListBucket",
          "s3:AbortMultipartUpload",
          "s3:ListBucketMultipartUploads"
        ],
        Resource: "arn:aws:s3:::${local.bucket_name}/*"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role" "read_write_role" {
  name = "epp-${var.env}-s3-read-write"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action: "sts:AssumeRoleWithWebIdentity",
        Effect: "Allow",
        Principal: {
          Federated: "arn:aws:iam::${var.account_id}:oidc-provider/${var.irsa_oidc_provider}"
        },
        Condition: {
          StringEquals: {
            "${var.irsa_oidc_provider}:sub": "system:serviceaccount:${var.irsa_namespace}:${var.irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "read-write-role-policy-attachment" {
  role       = aws_iam_role.read_write_role.name
  policy_arn = aws_iam_policy.read_write.arn
}
