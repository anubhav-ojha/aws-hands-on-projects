output "website_url" {
  description = "Public URL of the static website"
  value       = aws_s3_bucket.website.website_endpoint
}

output "access_log_bucket" {
  description = "Name of the access log bucket"
  value       = aws_s3_bucket.access_logs.bucket
}
