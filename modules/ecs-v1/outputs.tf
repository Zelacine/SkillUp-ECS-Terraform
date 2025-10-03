output "ecs_cluster_id" {
  value = aws_ecs_cluster.api_cluster.id
}

output "ecs_service_name" {
  value = aws_ecs_service.api_service.name
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.api_task.arn
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs_tasks.id
}