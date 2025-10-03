variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "region" {
  description = "AWS region for resources"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "subdomain" {
  description = "Subdomain name"
  type        = string
}

#
#variable "target_group_port" {
#  description = "Target group port"
#  type        = number
#  default     = 8000
#}

#variable "target_group_protocol" {
#  description = "Target group protocol"
#  type        = string
#  default     = "HTTP"
#}

# New variables for Target group health check
variable "target_groups" {
  description = "Map of target group configurations"
  type = map(object({
    port        = number
    protocol    = string
    path        = string
    interval    = number
    timeout     = number
    healthy     = number
    unhealthy   = number
    matcher     = string
  }))
  default = {
    default = {
      port        = 80
      protocol    = "HTTP"
      path        = "/"
      interval    = 30
      timeout     = 5
      healthy     = 5
      unhealthy   = 2
      matcher     = "200-299"
    }
    api = {
      port        = 8000
      protocol    = "HTTP"
      path        = "/health"
      interval    = 30
      timeout     = 5
      healthy     = 3
      unhealthy   = 2
      matcher     = "200-299"
    }
  }
}




variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}