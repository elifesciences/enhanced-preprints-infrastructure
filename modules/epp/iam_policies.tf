resource "aws_iam_policy" "read_write" {
  name        = "epp-${var.env}-s3-read-write"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read/write access"

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
          "arn:aws:s3:::${local.main_bucket_name}",
          "arn:aws:s3:::${local.meca_bucket_name}",
          "arn:aws:s3:::${local.pdf_bucket_name}",
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
          "arn:aws:s3:::${local.main_bucket_name}/*",
          "arn:aws:s3:::${local.meca_bucket_name}/*",
          "arn:aws:s3:::${local.pdf_bucket_name}/*",
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_prod_sources" {
  name        = "epp-${var.env}-s3-read-prod-sources"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read-only access to the prod env source buckets"

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
          "arn:aws:s3:::${local.prod_meca_bucket_name}",
          "arn:aws:s3:::${local.prod_pdf_bucket_name}",
        ]
      },
      {
        Sid : "AccessSubPaths",
        Effect : "Allow",
        Action : [
          "s3:GetObject",
          "s3:GetObjectAttributes",
          "s3:ListBucket",
        ],
        Resource : [
          "arn:aws:s3:::${local.prod_meca_bucket_name}/*",
          "arn:aws:s3:::${local.prod_pdf_bucket_name}/*",
        ]
      }
    ]
  })

  tags = local.tags
}


resource "aws_iam_policy" "read_only" {
  name        = "epp-${var.env}-s3-read-only"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read-only access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid : "List",
        Effect : "Allow",
        Action : [
          "s3:ListBucket"
        ],
        Resource : "arn:aws:s3:::${local.main_bucket_name}"
      },
      {
        Sid : "AccessSubPaths",
        Effect : "Allow",
        Action : [
          "s3:GetObject",
          "s3:GetObjectAttributes",
          "s3:ListBucket",
        ],
        Resource : "arn:aws:s3:::${local.main_bucket_name}/*"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_only_data_prefix" {
  name        = "epp-${var.env}-s3-read-only-data-prefix"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read-only access to /data"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid : "List",
        Effect : "Allow",
        Action : [
          "s3:ListBucket"
        ],
        Resource : "arn:aws:s3:::${local.main_bucket_name}"
      },
      {
        Sid : "AccessSubPaths",
        Effect : "Allow",
        Action : [
          "s3:GetObject",
          "s3:GetObjectAttributes",
          "s3:ListBucket",
        ],
        Resource : "arn:aws:s3:::${local.main_bucket_name}/data/*"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_only_automation_prefix" {
  name        = "epp-${var.env}-s3-read-only-automation-prefix"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read-only access to /automation"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid : "List",
        Effect : "Allow",
        Action : [
          "s3:ListBucket"
        ],
        Resource : "arn:aws:s3:::${local.main_bucket_name}"
      },
      {
        Sid : "AccessSubPaths",
        Effect : "Allow",
        Action : [
          "s3:GetObject",
          "s3:GetObjectAttributes",
          "s3:ListBucket",
        ],
        Resource : "arn:aws:s3:::${local.main_bucket_name}/automation/*"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_biorxiv_bucket" {
  name        = "epp-${var.env}-read-biorxiv-bucket"
  path        = "/"
  description = "EPP ${var.env} bioRxiv's S3 bucket access"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ],
            "Resource": [
                "arn:aws:s3:::transfers-elife",
                "arn:aws:s3:::transfers-elife/*",
                "arn:aws:s3:::medrxiv-src-daily",
                "arn:aws:s3:::medrxiv-src-daily/*",
                "arn:aws:s3:::biorxiv-src-daily",
                "arn:aws:s3:::biorxiv-src-daily/*",
            ]
        }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "become_biorxiv_role" {
  name = "epp-${var.env}-become-access-biorxiv-xml-role"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "sts:AssumeRole"
        ],
        Resource : [
          var.biorxiv_role_arn
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "read_write_sources" {
  name        = "epp-${var.env}-s3-read-write-sources"
  path        = "/"
  description = "EPP ${var.env} S3 bucket read/write access to meca and PDF bucket"

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
          "arn:aws:s3:::${local.meca_bucket_name}",
          "arn:aws:s3:::${local.pdf_bucket_name}",
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
          "arn:aws:s3:::${local.meca_bucket_name}/*",
          "arn:aws:s3:::${local.pdf_bucket_name}/*",
        ]
      }
    ]
  })

  tags = local.tags
}
