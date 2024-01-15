#tf-aws-s3-statefile

## Summary

Bootstrap process to enable a Remote Backend.
Provisions s3 bucket to host remote terraform state file.
Encryption will also be enabled with a kms key.
The dynamodb is used to create access locking for the state file.

## Process

- [ ] Deploy the Remote Backend infrastructure
- [ ] Terraform projects can now reference the backend:

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    key    = "tf-infra-dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}

```
