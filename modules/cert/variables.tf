variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}
variable "zone_id" {
  type = string
}
#variable "certificate_arn" {
#  description = "ARN of the ACM certificate to validate"
#  type        = string
#}
