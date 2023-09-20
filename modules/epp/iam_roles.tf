resource "aws_iam_role" "image_server_role" {
  name = "epp-${var.env}-image-server"

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
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.image_server_irsa_namespace}:${var.image_server_irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}
resource "aws_iam_role_policy_attachment" "image_server_read_only_role_policy_attachment" {
  role       = aws_iam_role.image_server_role.name
  policy_arn = aws_iam_policy.read_only.arn
}

resource "aws_iam_role" "epp_server_role" {
  name = "epp-${var.env}-epp-server"

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
            "${var.irsa_oidc_provider}:sub" : "system:serviceaccount:${var.epp_server_irsa_namespace}:${var.epp_server_irsa_service_account}"
          }
        }
      },
    ]
  })

  tags = local.tags
}
resource "aws_iam_role_policy_attachment" "epp_server_read_only_role_policy_attachment" {
  role       = aws_iam_role.epp_server_role.name
  policy_arn = aws_iam_policy.read_only_data_prefix.arn
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
resource "aws_iam_role_policy_attachment" "import-role-access-to-prod-sources-policy-attachment" {
  role       = aws_iam_role.import_role.name
  policy_arn = aws_iam_policy.read_prod_sources.arn
}
