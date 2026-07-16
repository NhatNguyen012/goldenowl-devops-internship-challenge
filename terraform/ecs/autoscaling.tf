resource "aws_appautoscaling_target" "ecs_service" {
  min_capacity = var.autoscaling_min_capacity
  max_capacity = var.autoscaling_max_capacity

  resource_id = join("/", ["service", aws_ecs_cluster.app.name, aws_ecs_service.app.name])

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_cpu" {
  name = "${local.name_prefix}-cpu-scaling"

  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.autoscaling_cpu_target

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    scale_out_cooldown = 60
    scale_in_cooldown  = 120
  }
}