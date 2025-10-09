output "certificate_arn" {
  description = "The ARN of the issued ACM certificate"
  #value       = aws_acm_certificate.app.arn
  value =  aws_acm_certificate_validation.app.certificate_arn
}
