provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "goldenowl-devops-internship-challenge"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "nhatnguyen"
    }
  }
}