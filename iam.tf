# IAM Role for AWS CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "as5.2-codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "tf-cicd-pipeline-policies" {
    statement{
        sid = ""
        actions = ["codestar-connections:UseConnection"]
        resources = ["*"]
        effect = "Allow"
    }
    statement{
        sid = ""
        actions = ["cloudwatch:*", "s3:*", "codebuild:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "tf-cicd-pipeline-policy" {
    name = "tf-cicd-pipeline-policy"
    path = "/"
    description = "Pipeline policy"
    policy = data.aws_iam_policy_document.tf-cicd-pipeline-policies.json
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "as5.2-codepipeline-policy"
  description = "IAM policy for AWS CodePipeline"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Actions = [
          "codepipeline:*",
          "codebuild:*",
          "cloudwatch:*",
          "s3:*",
          "ec2:*",
          "secretsmanager:*",
          "codestar-connection:UseConnection"
        ]
        Effect   = "Allow"
        Resources = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_attachment" {
  policy_arn = aws_iam_policy.codepipeline_policy.arn
  role = aws_iam_role.codepipeline_role.id
}

# IAM Role for AWS CodeBuild
resource "aws_iam_role" "codebuild_role" {
  name = "as5.2-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "tf-cicd-build-policies" {
    statement{
        sid = ""
        actions = ["logs:*", "s3:*", "codebuild:*", "secretsmanager:*","iam:*"]
        resources = ["*"]
        effect = "Allow"
    }
}

resource "aws_iam_policy" "tf-cicd-build-policy" {
    name = "tf-cicd-build-policy"
    path = "/"
    description = "Codebuild policy"
    policy = data.aws_iam_policy_document.tf-cicd-build-policies.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-codebuild-attachment1" {
    policy_arn  = aws_iam_policy.tf-cicd-build-policy.arn
    role        = aws_iam_role.tf-codebuild-role.id
}


resource "aws_iam_policy" "codebuild_policy" {
  name        = "as5.2-codebuild-policy"
  description = "IAM policy for AWS CodeBuild"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Actions = [
          "logs:*",
          "s3:*",
          "codebuild:*",
          "iam:*",
          "secretsmanager:*",
          "ec2:*",
        ]
        Effect   = "Allow"
        Resources = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role = aws_iam_role.codebuild_role.id
}
