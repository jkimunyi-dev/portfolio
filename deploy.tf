provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "ci_cd_bucket" {
  bucket = "ci-cd-artifacts-bucket"
}

resource "aws_iam_role" "codebuild_role" {
  name = "ci-cd-codebuild-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "codebuild.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

resource "aws_codebuild_project" "ci_cd_build" {
  name = "ci-cd-build"
  source {
    type      = "GITHUB"
    location  = "https://github.com/user/repo"
  }
  artifacts {
    type = "S3"
    location = aws_s3_bucket.ci_cd_bucket.bucket
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  service_role = aws_iam_role.codebuild_role.arn
}
