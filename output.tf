output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.cert.certificate_arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.elb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the ALB"
  value       = module.elb.alb_zone_id
}