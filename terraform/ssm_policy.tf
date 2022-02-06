data "aws_iam_policy_document" "ssm_policy_document" {
  statement {
    actions = [
      "ssm:GetParameters"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ssm_policy" {
  name = "${local.project_name}-ssm-policy"
  policy = data.aws_iam_policy_document.ssm_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role = aws_iam_role.service_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}
