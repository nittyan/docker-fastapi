resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role = aws_iam_role.service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

data "aws_iam_policy_document" "ecr_push_policy_document" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = [
      aws_ecr_repository.repository.arn
    ]
  }
}

resource "aws_iam_policy" "ecr_push_policy" {
  name = "${local.project_name}-ecr-push-policy"
  policy = data.aws_iam_policy_document.ecr_push_policy_document.json
  tags = {
    "created_by": "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecr_push_policy_attachment" {
  role = aws_iam_role.service_role.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}
