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

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "as5.2-codepipeline-policy"
  description = "IAM policy for AWS CodePipeline"

  policy = jsonencode({
    Version = "2012-10-17",
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
        ],
        Effect   = "Allow",
        Resources = ["*"],
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_attachment" {
  name        = "as5.2-codepipeline-attachment"
  policy_arn = aws_iam_policy.codepipeline_policy.arn
  role = aws_iam_role.codepipeline-role.id
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

resource "aws_iam_policy" "codebuild_policy" {
  name        = "as5.2-codebuild-policy"
  description = "IAM policy for AWS CodeBuild"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Actions = [
          "logs:*",
          "s3:*",
          "codebuild:*",
          "iam:*",
          "secretsmanager:*",
          "ec2:*",
        ],
        Effect   = "Allow",
        Resources = ["*"],
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attachment" {
  name        = "as5.2-codebuild-attachment"
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role = aws_iam_role.codebuild_role.id
}
