
resource "aws_iam_role" "read_write_role" {
  name = "epp-${var.env}-s3-read-write"

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
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.read_write_irsa_namespace}:${var.read_write_irsa_service_account}"
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


resource "aws_iam_role" "read_only_role" {
  name = "epp-${var.env}-s3-read-only"

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
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.read_only_irsa_namespace}:${var.read_only_irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}
resource "aws_iam_role_policy_attachment" "read-only-role-policy-attachment" {
  role       = aws_iam_role.read_only_role.name
  policy_arn = aws_iam_policy.read_only.arn
}


resource "aws_iam_role" "import_role" {
  name = "epp-${var.env}-import"

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
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.import_irsa_namespace}:${var.import_irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "import-role-s3-read-write-policy-attachment" {
  role       = aws_iam_role.import_role.name
  policy_arn = aws_iam_policy.read_write.arn
}
resource "aws_iam_role_policy_attachment" "import-role-biorxiv-access-policy-attachment" {
  role       = aws_iam_role.import_role.name
  policy_arn = aws_iam_policy.read_biorxiv_bucket.arn
}
