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

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "project_name" {
  type    = string
  default = "goldenowl-devops-challenge"
}

variable "environment" {
  type    = string
  default = "test"
}

variable "vpc_cidr" {
  description = "CIDR for application VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR for public subnets across AZ"
  type        = list(string)

  default = [
    "10.20.1.0/24",
    "10.20.2.0/24",
  ]

  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "Need at least two public subnets"
  }
}

variable "alb_ingress_cidrs" {
  description = "CIDR for ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "container_image" {
  description = "ECR image URI for the initial ECS deployment"
  type        = string
}

variable "container_name" {
  type    = string
  default = "goldenowl-app"
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "desired_count" {
  description = "Initial desired number of ECS tasks"
  type        = number
  default     = 1
}

variable "autoscaling_min_capacity" {
  description = "Minimum number of tasks"
  type        = number
  default     = 1
}

variable "autoscaling_max_capacity" {
  type    = number
  default = 2
}

variable "task_cpu" {
  description = "CPU for each task"
  type        = number
  default     = 512
}

variable "task_memory" {
  description = "Memory for each task"
  type        = number
  default     = 1024
}

variable "autoscaling_cpu_target" {
  description = "Average CPU utilization target"
  type        = number
  default     = 70
}

variable "log_retention_days" {
  type    = number
  default = 7
}