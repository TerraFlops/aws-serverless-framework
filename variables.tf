variable "serverless_deployment_policy_external_id" {
  description = "The external ID of the Serverless account that should be granted access to the deployment IAM role"
  type = string
}

variable "deployment_bucket_name" {
  description = "Deployment bucket name. If not supplied a name will be automatically generating using the AWS account ID and the prefix/suffix variable values"
  type = string
  default = null
}

variable "deployment_bucket_versioning" {
  description = "Boolean flag, if true versioning will be enabled in the S3 deployment bucket (defaults to true)"
  type = string
  default = true
}

variable "deployment_bucket_block_public_policy" {
  description = "Boolean flag, if true a policy will be added to the bucket blocking public access permissions (defaults to true)"
  type = string
  default = true
}

variable "deployment_bucket_prefix" {
  description = "When a specific deployment_bucket_name is not supplied, this optional prefix will be prepending to the deployment bucket name (if none supplied this will default to 'artifacts.serverless')"
  type = string
  value = "artifacts.serverless"
}

variable "deployment_bucket_suffix" {
  description = "When a specific deployment_bucket_name is not supplied, this optional suffix to be appended to the deployment bucket name"
  type = string
  value = ""
}
