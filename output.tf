output "iam_role" {
  description = "IAM role resource created for deployment of Serverless framework projects"
  value = var.create_iam_role == true ? aws_iam_role.serverless_deployment_role : null
}

output "iam_role_arn" {
  description = "IAM role ARN created for deployment of Serverless framework projects"
  value = var.create_iam_role == true ? aws_iam_role.serverless_deployment_role.arn : null
}

output "artifact_bucket" {
  description = "S3 bucket resource created for deployment of Serverless framework artifacts"
  value = var.create_deployment_bucket == true ? aws_s3_bucket.serverless_deployment_bucket : null
}

output "artifact_bucket_arn" {
  description = "S3 bucket ARN created for deployment of Serverless framework artifacts"
  value = var.create_deployment_bucket == true ? aws_s3_bucket.serverless_deployment_bucket.arn : null
}

output "artifact_bucket_name" {
  description = "S3 bucket name created for deployment of Serverless framework artifacts"
  value = var.create_deployment_bucket == true ? aws_s3_bucket.serverless_deployment_bucket.bucket : null
}