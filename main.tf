terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

# Configure the AWS Provider plug-in so we can interact with AWS API
provider "aws" {
  region = "us-east-1"
}

# Create kms key
resource "aws_kms_key" "terraform_state_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

# Create s3 bucket
resource "aws_s3_bucket" "terraform_state" {
    bucket = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    
}

# Create s3 server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id
    rule {
        apply_server_side_encryption_by_default {
            kms_master_key_id = aws_kms_key.terraform_state_key.arn
            sse_algorithm = "AES256"
        }
    }
}

# Create dynamo db table
resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-state-locking"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }

}