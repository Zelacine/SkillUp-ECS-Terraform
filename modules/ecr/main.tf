resource "aws_ecr_repository" "my_ecr_repo" {
  count = var.create_ecr_repository ? 1 : 0

  name = "my-flask-app-alpine"

  image_scanning_configuration {
    scan_on_push = false
  }

  lifecycle {
    ignore_changes = [image_scanning_configuration]  # Prevents changes to image scanning configuration from triggering recreation
  }
}

resource "aws_ecr_repository_policy" "my_ecr_repo_policy" {
  count = var.create_ecr_repository ? 1 : 0

  repository = aws_ecr_repository.my_ecr_repo[0].name  # Specify which instance to refer to

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "ecr:*",
      Condition = {
        IpAddress = {
          "aws:SourceIp" = var.allowed_vpn_users  # Allow access from specified VPN IP addresses
        }
      }
    }]
  })
}

resource "null_resource" "upload_docker_image_to_ecr" {
  count = var.upload_docker_image ? 1 : 0

  triggers = {
    always_run = timestamp()  # Always run this resource
  }

  provisioner "local-exec" {
   command = "bash ${var.upload_image_script_path}"  # Replace with the actual script to upload Docker image
  }
}
