# IAM Role for AWS CodePipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "as5.2-codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

data "aws_iam_policy_document" "codepipeline_policies" {
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

resource "aws_iam_policy" "codepipeline_policy" {
    name = "as5.2-codepipeline-policy"
    path = "/"
    description = "codeipeline policy"
    policy = data.aws_iam_policy_document.codepipeline_policies.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_attachment" {
  policy_arn = aws_iam_policy.codepipeline_policy.arn
  role = aws_iam_role.codepipeline_role.id
}
