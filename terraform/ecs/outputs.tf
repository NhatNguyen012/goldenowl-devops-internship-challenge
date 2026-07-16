output "application_url" {
  description = "Public URL of the deployed application"
  value       = "http://${aws_lb.app.dns_name}"
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.app.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app.name
}

output "ecs_task_definition_family" {
  description = "Task definition family used by application"
  value       = aws_ecs_task_definition.app.family
}

output "ecs_container_name" {
  description = "Container name used inside the ECS task definition"
  value       = var.container_name
}

output "github_deployer_role_arn" {
  description = "IAM role assumed by GitHub Actions for ECR push and ECS deploy"
  value       = aws_iam_role.github_deployer.arn
}