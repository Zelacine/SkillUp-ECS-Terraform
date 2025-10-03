# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  type        = string
  description = "AWS region for all resources."
  #default = "eu-central-2"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."
  default = "SkillUp-terraform"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/26", "10.0.2.0/26"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/26", "10.0.4.0/26"]
}

variable "public_subnet_tags" {
  description = "Tags for public subnets"
  type        = map(string)
  default     = { "Environment" = "prod" }
}

variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default     = { "Environment" = "prod" }
}
variable "domain_name" {
  description = "The root domain name"
  type        = string
  default     = "d888k.xyz"
}

variable "subdomain" {
  description = "The subdomain (FQDN) for the application"
  type        = string
  default     = "www.d888k.xyz"
}

variable "subject_alternative_names" {
  description = "List of SANs for ACM cert (e.g. subdomains)"
  type        = list(string)
  default     = []
}
#variable "api_image" {
#  description = "Docker image for the ECS API app"
#  type        = string
#}
#variable "ecr_repo_url" {
#  type        = string
#  description = "ECR repo URL (with tag) e.g. 123456789.dkr.ecr.eu-central-1.amazonaws.com/my-flask-app:latest"
#}
variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
  default     = ""
}