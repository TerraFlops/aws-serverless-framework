output "iam_role" {
  description = "IAM role resource created for deployment of Serverless framework projects"
  value = var.create_iam_role == true ? aws_iam_role.serverless_deployment_role[0] : null
}

output "iam_role_arn" {
  description = "IAM role ARN created for deployment of Serverless framework projects"
  value = var.create_iam_role == true ? aws_iam_role.serverless_deployment_role[0].arn : null
}

output "artifact_bucket" {
  description = "S3 bucket resource created for deployment of Serverless framework artifacts"
  value = var.create_deployment_bucket == true ? aws_s3_bucket.serverless_deployment_bucket[0] : null
}

output "artifact_bucket_arn" {
  description = "S3 bucket ARN created for deployment of Serverless framework artifacts"
  value = var.create_deployment_bucket == true ? aws_s3_bucket.serverless_deployment_bucket[0].arn : null
}

output "artifact_bucket_name" {
  description = "S3 bucket name created for deployment of Serverless framework artifacts"
  value = var.create_deployment_bucket == true ? aws_s3_bucket.serverless_deployment_bucket[0].bucket : null
}