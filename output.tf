output "iam_role" {
  description = "IAM role resource created for deployment of Serverless framework projects"
  value = aws_iam_role.serverless_deployment_role
}

output "iam_role_arn" {
  description = "IAM role ARN created for deployment of Serverless framework projects"
  value = aws_iam_role.serverless_deployment_role.arn
}

output "artifact_bucket" {
  description = "S3 bucket resource created for deployment of Serverless framework artifacts"
  value = aws_s3_bucket.serverless_deployment_bucket
}

output "artifact_bucket_arn" {
  description = "S3 bucket ARN created for deployment of Serverless framework artifacts"
  value = aws_s3_bucket.serverless_deployment_bucket.arn
}

output "artifact_bucket_name" {
  description = "S3 bucket name created for deployment of Serverless framework artifacts"
  value = aws_s3_bucket.serverless_deployment_bucket.bucket
}