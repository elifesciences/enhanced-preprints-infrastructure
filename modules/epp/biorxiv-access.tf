resource "aws_iam_policy" "biorxiv_transfers_elife_read_access" {
  name        = "epp-${var.env}-biorxiv-transfers-elife-read-access"
  path        = "/"
  description = "EPP ${var.env} read access to biorxiv's transfers-elife bucket"

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: [
          "s3:Get*",
          "s3:List*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*"
        ],
        Resource: [
          "arn:aws:s3:::transfers-elife",
          "arn:aws:s3:::transfers-elife/*"
        ]
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role" "biorxiv_transfers_elife_role" {
  name = "epp-${var.env}-biorxiv-transfers-elife-access"

  assume_role_policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: {
          AWS: "arn:aws:iam::512686554592:root"
        },
        Action: "sts:AssumeRole",
        Condition: {}
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "biorxiv_transfers_elife_role_read_access_policy_attachment" {
  role       = aws_iam_role.biorxiv_transfers_elife_role.name
  policy_arn = aws_iam_policy.biorxiv_transfers_elife_read_access.arn
}
