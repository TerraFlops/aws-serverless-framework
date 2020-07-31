# Retrieve the AWS account ID for use in the bucket name
data "aws_caller_identity" "serverless_deployment_account" {
}

# Create IAM policy document allowing Serverless Framework enterprise to assume this role for deployments
data "aws_iam_policy_document" "serverless_deployment_policy_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::802587217904:root"
      ]
    }
    condition {
      test = "StringEquals"
      values = [
        var.serverless_deployment_policy_external_id
      ]
      variable = "sts:ExternalId"
    }
  }
}

# Create policy allowing Serverless Framework full access to the account for deployment purposes
data "aws_iam_policy_document" "serverless_deployment_policy" {
  version = "2012-10-17"
  statement {
    actions = [
      "*"
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}

# Attach policy to the newly created role
resource "aws_iam_role_policy" "serverless_deployment_policy" {
  count = var.create_iam_role == true ? 1 : 0
  name = "ServerlessDeployment"
  role = aws_iam_role.serverless_deployment_role[0].name
  policy = data.aws_iam_policy_document.serverless_deployment_policy.json
}

# Create IAM role that will be used by the Serverless framework when performing deployments in the account
resource "aws_iam_role" "serverless_deployment_role" {
  count = var.create_iam_role == true ? 1 : 0
  name = "ServerlessDeployment"
  description = "Role used by Serverless Framework for automated deployments in this account"
  assume_role_policy = data.aws_iam_policy_document.serverless_deployment_policy_assume_role.json
  force_detach_policies = true
  tags = {
    Name = "ServerlessDeployment"
  }
}

# Create custom deployment bucket
resource "aws_s3_bucket" "serverless_deployment_bucket" {
  count = var.create_deployment_bucket == true ? 1 : 0
  # Deployment bucket name, if none is supplied the name will be procedurally generated
  bucket = var.deployment_bucket_name == null ? "${var.deployment_bucket_prefix}.${data.aws_caller_identity.serverless_deployment_account.account_id}.${var.deployment_bucket_suffix}" : var.deployment_bucket_name

  # Enable bucket versioning if requested
  versioning {
    enabled = var.deployment_bucket_versioning
  }

  # Enable S3 bucket encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

# Block public access policies on the bucket if requested
resource "aws_s3_bucket_public_access_block" "serverless_deployment_bucket" {
  count = var.create_deployment_bucket == true && var.deployment_bucket_block_public_policy ? 1 : 0
  bucket = aws_s3_bucket.serverless_deployment_bucket[0].bucket
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}