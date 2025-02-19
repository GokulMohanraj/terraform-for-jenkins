output "instance_id" {
  description = "This is aws instance id"
  value       = aws_instance.demo.id
}

output "instance_ip" {
  description = "This is aws instance public ip"
  value       = aws_instance.demo.public_ip
}

output "aws_s3_bucket" {
  description = "This is aws s3 bucket name"
  value       = aws_s3_bucket.demo-bucket.bucket
  
}