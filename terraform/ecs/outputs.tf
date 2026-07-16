output "application_url" {
  description = "Public URL of the deployed application"
  value       = "http://${aws_lb.app.dns_name}"
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.app.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.app.arn
}

output "target_group_arn" {
  description = "ARN of the ECS ALB target group"
  value       = aws_lb_target_group.app.arn
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.app.name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.app.arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.app.name
}

output "ecs_service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.app.id
}

output "ecs_task_definition_family" {
  description = "Task definition family used by application"
  value       = aws_ecs_task_definition.app.family
}

output "ecs_task_definition_arn" {
  description = "ARN of the initial ECS task definition revision"
  value       = aws_ecs_task_definition.app.arn
}

output "ecs_task_execution_role_arn" {
  description = "Execution role that GitHub Actions may pass when register task definitions"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  description = "Application task role ARN"
  value       = aws_iam_role.ecs_task.arn
}

output "cloudwatch_log_group_name" {
  description = "CloudWatch log group contain application logs"
  value       = aws_cloudwatch_log_group.app.name
}

output "public_subnet_ids" {
  description = "Public subnet IDs used by ALB and ECS"
  value = [
    for subnet in aws_subnet.public :
    subnet.id
  ]
}