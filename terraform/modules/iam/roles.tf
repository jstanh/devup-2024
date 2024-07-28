resource "aws_iam_role" "ecsInstanceRole" {
  name        = "ecsinstanceRole"
  description = "Allows EC2 instances in an ECS cluster to access ECS."
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_service_role_attach" {
  role       = aws_iam_role.ecsInstanceRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}



resource "aws_iam_role" "ecsTaskExecutionRole" {
  name        = "ecsTaskExecutionRole"
  description = ""
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attach" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "codebuild_role" {
  name               = "codebuild-service-role"
  assume_role_policy    = jsonencode(
           {
               Statement = [
                   {
                       Action    = "sts:AssumeRole"
                       Effect    = "Allow"
                       Principal = {
                           Service = "codebuild.amazonaws.com"
                        }
                    },
                ]
               Version   = "2012-10-17"
            }
        )
  managed_policy_arns = [ "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
  aws_iam_policy.codebuild_policy.arn ]
  path = "/service-role/"
  tags = {}
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "AWSCodePipelineServiceRole"
  assume_role_policy    = jsonencode(
           {
               Statement = [
                   {
                       Action    = "sts:AssumeRole"
                       Effect    = "Allow"
                       Principal = {
                           Service = "codepipeline.amazonaws.com"
                        }
                    },
                ]
               Version   = "2012-10-17"
            }
        )
  managed_policy_arns = [ aws_iam_policy.codepipeline_policy.arn ]
  path = "/service-role/"
  tags = {}
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "AWSCodePipelineServiceRole"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodePipeline"

  policy = jsonencode(
          {
              Statement = [
                  {
                      Action    = [
                          "iam:PassRole",
                        ]
                      Condition = {
                          StringEqualsIfExists = {
                              "iam:PassedToService" = [
                                  "cloudformation.amazonaws.com",
                                  "elasticbeanstalk.amazonaws.com",
                                  "ec2.amazonaws.com",
                                  "ecs-tasks.amazonaws.com",
                                ]
                            }
                        }
                        Effect    = "Allow"
                        Resource  = "*"
                    },
                  {
                      Action   = [
                          "codecommit:CancelUploadArchive",
                          "codecommit:GetBranch",
                          "codecommit:GetCommit",
                          "codecommit:GetRepository",
                          "codecommit:GetUploadArchiveStatus",
                          "codecommit:UploadArchive",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "codedeploy:CreateDeployment",
                          "codedeploy:GetApplication",
                          "codedeploy:GetApplicationRevision",
                          "codedeploy:GetDeployment",
                          "codedeploy:GetDeploymentConfig",
                          "codedeploy:RegisterApplicationRevision",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "codestar-connections:UseConnection",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "elasticbeanstalk:*",
                          "ec2:*",
                          "elasticloadbalancing:*",
                          "autoscaling:*",
                          "cloudwatch:*",
                          "s3:*",
                          "sns:*",
                          "cloudformation:*",
                          "rds:*",
                          "sqs:*",
                          "ecs:*",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "lambda:InvokeFunction",
                          "lambda:ListFunctions",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "opsworks:CreateDeployment",
                          "opsworks:DescribeApps",
                          "opsworks:DescribeCommands",
                          "opsworks:DescribeDeployments",
                          "opsworks:DescribeInstances",
                          "opsworks:DescribeStacks",
                          "opsworks:UpdateApp",
                          "opsworks:UpdateStack",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "cloudformation:CreateStack",
                          "cloudformation:DeleteStack",
                          "cloudformation:DescribeStacks",
                          "cloudformation:UpdateStack",
                          "cloudformation:CreateChangeSet",
                          "cloudformation:DeleteChangeSet",
                          "cloudformation:DescribeChangeSet",
                          "cloudformation:ExecuteChangeSet",
                          "cloudformation:SetStackPolicy",
                          "cloudformation:ValidateTemplate",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "codebuild:BatchGetBuilds",
                          "codebuild:StartBuild",
                          "codebuild:BatchGetBuildBatches",
                          "codebuild:StartBuildBatch",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "devicefarm:ListProjects",
                          "devicefarm:ListDevicePools",
                          "devicefarm:GetRun",
                          "devicefarm:GetUpload",
                          "devicefarm:CreateUpload",
                          "devicefarm:ScheduleRun",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "servicecatalog:ListProvisioningArtifacts",
                          "servicecatalog:CreateProvisioningArtifact",
                          "servicecatalog:DescribeProvisioningArtifact",
                          "servicecatalog:DeleteProvisioningArtifact",
                          "servicecatalog:UpdateProduct",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "cloudformation:ValidateTemplate",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "ecr:DescribeImages",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "states:DescribeExecution",
                          "states:DescribeStateMachine",
                          "states:StartExecution",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                  {
                      Action   = [
                          "appconfig:StartDeployment",
                          "appconfig:StopDeployment",
                          "appconfig:GetDeployment",
                        ]
                      Effect   = "Allow"
                      Resource = "*"
                    },
                ]
                Version   = "2012-10-17"
            }
        )
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "CodeBuildBasePolicy"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = jsonencode(
          {
              Statement = [
                  {
                      Action   = [
                          "logs:CreateLogGroup",
                          "logs:CreateLogStream",
                          "logs:PutLogEvents"
                        ]
                        Effect   = "Allow"
                      Resource = [
                          "*",
                        ] 
                  },
                  {
                      Action   = [
                          "s3:PutObject",
                          "s3:GetObject",
                          "s3:GetObjectVersion",
                          "s3:GetBucketAcl",
                          "s3:GetBucketLocation",
                        ]
                      Effect   = "Allow"
                      Resource = [
                          "*"
                        ]
                    },
                  {
                      Action   = [
                          "codebuild:CreateReportGroup",
                          "codebuild:CreateReport",
                          "codebuild:UpdateReport",
                          "codebuild:BatchPutTestCases",
                          "codebuild:BatchPutCodeCoverages",
                        ]
                      Effect   = "Allow"
                      Resource = [
                          "*"
                        ]
                    },
                ]
                Version   = "2012-10-17"
            }
        )
}


