output "image_uri" {
  description = "Full URI of the uploaded Docker image"
  value       = "${aws_ecr_repository.my_ecr_repo[0].repository_url}:latest"
}