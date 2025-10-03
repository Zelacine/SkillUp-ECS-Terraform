output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "alb_zone_id" {
  value = aws_lb.app.zone_id
}

output "lb_sg_id" {
  description = "Security group ID(s) for the load balancer"
  value       = var.security_groups
}
output "target_group_arns" {
  description = "Map of target group ARNs"
  value = {
    for k, v in aws_lb_target_group.app : k => v.arn
  }
}

# If you specifically need the default target group ARN
output "default_target_group_arn" {
  description = "ARN of the default target group"
  value       = aws_lb_target_group.app["default"].arn
}
