resource "aws_codebuild_project" "plan" {
  name          = "as5.2-cicd-plan"
  description   = "Plan stage for terraform"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:0.14.3"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential{
        credential = var.dockerhub_credentials
        credential_provider = "SECRETS_MANAGER"
    }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/plan.yml")
 }
}

resource "aws_codebuild_project" "apply" {
  name          = "as5.2-cicd-apply"
  description   = "Apply stage for terraform"
  service_role  = aws_iam_role.codepipeline_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:0.14.3"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential{
        credential = var.dockerhub_credentials
        credential_provider = "SECRETS_MANAGER"
    }
 }
 source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/apply.yml")
 }
}


resource "aws_codepipeline" "cicd_pipeline" {
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
            output_artifacts = ["as5.2-tf-code"]
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
            input_artifacts = ["as5.2-tf-code"]
            configuration = {
                ProjectName = "as5.2-tf-cicd-plan"
            }
        }
    }

    stage {
        name ="Deploy"
        action{
            name = "Deploy"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["as5.2-tf-code"]
            configuration = {
                ProjectName = "as5.2-tf-cicd-apply"
            }
        }
    }

}