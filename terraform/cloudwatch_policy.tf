data "aws_iam_policy_document" "cloudwatch_policy_document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_policy" {
  name = "${local.project_name}-cloudwatch-policy"
  policy = data.aws_iam_policy_document.cloudwatch_policy_document.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
  role = aws_iam_role.service_role.name
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}
