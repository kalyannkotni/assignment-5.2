resource "aws_codepipeline" "codepipeline" {
  name = "as5.2-cicd"
  role_arn = aws_iam_role.codepipeline_role.arn

    artifact_store {
        type="S3"
        location = aws_s3_bucket.cicd_artifacts.id
    }

    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "AWS"
            provider = "CodeStarSourceConnection"
            version = "1"
            output_artifacts = ["as52-tf-code"]
            configuration = {
                FullRepositoryId = "kalyannkotni/assignment-5.2"
                BranchName   = "main"
                ConnectionArn = var.codestar_connector_credentials
                OutputArtifactFormat = "CODE_ZIP"
            }
        }
    }

    stage {
        name ="Plan"
        action{
            name = "Build"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["as52-tf-code"]
            configuration = {
                ProjectName = "as5.2-tf-cicd-plan"
            }
        }
    }

}
