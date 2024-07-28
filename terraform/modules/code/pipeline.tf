resource "aws_codepipeline" "api_pipeline" {
  name     = var.code_pipeline_name
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.codebuild_bucket_id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      namespace        = "SourceVariables"
      configuration = {
        "BranchName"           = "main"
        "OutputArtifactFormat" = "CODE_ZIP"
        "PollForSourceChanges" = "false"
        "RepositoryName"       = aws_codecommit_repository.api.repository_name
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      namespace        = "BuildVariables"
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.api_build.name
      }
    }
  }

  # This can be added once the task definition is updated to use the new container in ECR
  # stage { 
  #   name = "Deploy"

  #   action {
  #     name            = "Deploy"
  #     category        = "Deploy"
  #     owner           = "AWS"
  #     provider        = "ECS"
  #     input_artifacts = ["BuildArtifact"]
  #     version         = "1"
  #     namespace       = "DeployVariables"
  #     configuration = {
  #       "ClusterName" = var.cluster_name
  #       "ServiceName" = var.service_name
  #     }
  #   }
  # }
}