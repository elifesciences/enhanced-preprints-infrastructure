resource "aws_iam_group" "developers" {
  name = "epp-${var.env}-developers"
}
resource "aws_iam_group_policy_attachment" "read-write-role-policy-attachment" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.read_write.arn
}
resource "aws_iam_group_policy_attachment" "read_become_biorxiv_role_attachment" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.become_biorxiv_role.arn
}
