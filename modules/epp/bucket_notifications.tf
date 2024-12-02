locals {
  meca_sns_name  = "${var.env}-elife-${local.project_name}-meca"
}
# Allow silent-corrections notifications from the MECA bucket to SNS
# (SNS subscriptions are managed downstream as part of the listening resource)
data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:${local.meca_sns_name}"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.meca_bucket.arn]
    }
  }
}
resource "aws_sns_topic" "meca_bucket_notification_topic" {
  name   = local.meca_sns_name
  policy = data.aws_iam_policy_document.topic.json
}

resource "aws_s3_bucket_notification" "meca_bucket_notification" {
  bucket = aws_s3_bucket.meca_bucket.id

  topic {
    topic_arn     = aws_sns_topic.meca_bucket_notification_topic.arn
    events        = ["s3:ObjectCreated:*"]
    # filter_prefix = "silent-corrections/"
    # filter_suffix = ".meca"
  }
}
