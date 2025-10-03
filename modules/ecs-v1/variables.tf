variable "cluster_name" {
  description = "Name for the ECS cluster"
  type        = string
}

variable "api_image" {
  description = "Docker image for the API app"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "container_env" {
  description = "Environment variables for the container"
  type        = list(object({
    name  = string
    value = string
  }))
  default     = []
}

variable "task_cpu" {
  description = "CPU units for the task"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Memory for the task"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Number of desired tasks"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "lb_sg_id" {
  description = "Security group ID of the load balancer"
  type        = string
}

variable "lb_target_group_arn" {
  description = "ARN of the load balancer target group"
  type        = string
}
