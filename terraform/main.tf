data "aws_caller_identity" "current" {}

locals {
  allowed_github_subjects = compact([
    "repo:${var.github_owner}/${var.github_repository_name}:ref:refs/heads/${var.github_branch}",
    var.github_owner_id != "" && var.github_repository_id != "" ? "repo:${var.github_owner}@${var.github_owner_id}/${var.github_repository_name}@${var.github_repository_id}:ref:refs/heads/${var.github_branch}" : ""
  ])
}

# Create ECR repository
resource "aws_ecr_repository" "app" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Create ECR lifecycle policy: Only keep 10 images
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep the latest 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}

# Connect OIDC GitHub Action
resource "aws_iam_openid_connect_provider" "github" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

# Create IAM policy document for GitHub Actions
data "aws_iam_policy_document" "github_assume_role" {
  statement {
    sid    = "AllowGitHubActionsOIDC"
    effect = "Allow"
    # Convert OIDC to AWS temporary credentials to assume role
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = local.allowed_github_subjects
    }
  }
}

# Create IAM role for GitHub Actions
resource "aws_iam_role" "github_ecr_publisher" {
  name               = "goldenowl-ecr-publisher"
  description        = "Allows the Golden Owl GitHub Actions workflow to push images to ECR"
  assume_role_policy = data.aws_iam_policy_document.github_assume_role.json
}

# Create IAM policy document for ECR publishing
data "aws_iam_policy_document" "ecr_publish" {
  statement {
    sid       = "GetECRAuthorizationToken"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "PushAndReadApplicationImages"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = [aws_ecr_repository.app.arn]
  }
}

# Create IAM role policy for ECR publishing
resource "aws_iam_role_policy" "ecr_publish" {
  name   = "goldenowl-ecr-publish"
  role   = aws_iam_role.github_ecr_publisher.id
  policy = data.aws_iam_policy_document.ecr_publish.json
}