variable "create_ecr_repository" {
  description = "Flag to create ECR repository"
  type        = bool
  default     = true
}

variable "upload_docker_image" {
  description = "Flag to upload Docker image to ECR"
  type        = bool
  default     = true
}

variable "allowed_vpn_users" {
  description = "List of users with Xtime VPN turned on allowed to push images to ECR"
  type        = list(string)
  #default     = ["x.x.x.x/32", "y.y.y.y/32"]  # Default IP addresses
  default     = ["91.225.6.72/32"]
}

variable "upload_image_script_path" {
  description = "Path to the script for uploading Docker image"
  type        = string
  default     = "scripts/upload_image222.sh"
}