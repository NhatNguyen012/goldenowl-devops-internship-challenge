variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "ecr_repository_name" {
  type    = string
  default = "goldenowl-devops-challenge"
}

# Both Github's names and immutable IDs are supported but limited in master branch
variable "github_owner" {
  type    = string
  default = "NhatNguyen012"
}

variable "github_repository_name" {
  type    = string
  default = "goldenowl-devops-internship-challenge"
}

variable "github_branch" {
  type    = string
  default = "master"
}

variable "github_owner_id" {
  type    = string
  default = ""
}

variable "github_repository_id" {
  type    = string
  default = ""
}