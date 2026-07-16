provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "goldenowl-devops-internship-challenge"
      ManagedBy = "Terraform"
      Owner     = "nhatnguyen"
    }
  }
}