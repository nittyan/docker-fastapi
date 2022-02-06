resource "aws_codebuild_project" "build" {
  name         = local.project_name
  service_role = aws_iam_role.service_role.arn
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true
  }
  source {
    type = "GITHUB"
    location = "https://github.com/nittyan/docker-fastapi"
  }
}

resource "aws_iam_role" "service_role" {
  name = "${local.project_name}-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    "created_by": "terraform"
  }
}

resource "aws_ecr_repository" "repository" {
  name   = "${local.project_name}-repository"
}
