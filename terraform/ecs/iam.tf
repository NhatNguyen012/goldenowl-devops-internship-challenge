# Allow ECS tasks to assume role to get temp credential for call API 
data "aws_iam_policy_document" "ecs_tasks_assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Attach role for ECS Agent to pull images in ECR 
resource "aws_iam_role" "ecs_task_execution" {
  name               = "${local.name_prefix}-execution-role"
  description        = "Allows ECS to pull images from ECR"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json
}

# Attach manage policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Role for app in container
resource "aws_iam_role" "ecs_task" {
  name               = "${local.name_prefix}-task-role"
  description        = "Application task role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json
}
