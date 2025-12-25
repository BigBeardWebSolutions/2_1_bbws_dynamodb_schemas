# DynamoDB Tables for BBWS Multi-Tenant Platform
#
# This Terraform configuration creates DynamoDB tables for:
# - Tenants (organizations and users)
# - Products (subscription tiers and features)
# - Campaigns (marketing campaigns)
#
# Region: Configured per environment (DEV/SIT: eu-west-1, PROD: af-south-1)
# Billing: PAY_PER_REQUEST (on-demand)
# PITR: Enabled
# Streams: Enabled for replication

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "bbws-terraform-state-dev"
    key            = "dynamodb/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock-dev"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
      Component   = "DynamoDB"
      Application = "BBWS"
    }
  }
}

# Tenants Table
resource "aws_dynamodb_table" "tenants" {
  name         = "tenants"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PK"
  range_key    = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }

  attribute {
    name = "active"
    type = "N"
  }

  # GSI: Email lookup
  global_secondary_index {
    name            = "EmailIndex"
    hash_key        = "email"
    projection_type = "ALL"
  }

  # GSI: Status filtering
  global_secondary_index {
    name            = "TenantStatusIndex"
    hash_key        = "status"
    range_key       = "SK"
    projection_type = "ALL"
  }

  # GSI: Active tenants
  global_secondary_index {
    name            = "ActiveIndex"
    hash_key        = "active"
    range_key       = "SK"
    projection_type = "ALL"
  }

  # Enable Point-in-Time Recovery
  point_in_time_recovery {
    enabled = true
  }

  # Enable DynamoDB Streams for replication
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  tags = {
    Name        = "tenants"
    Owner       = "Platform Team"
    CostCenter  = "Engineering"
  }
}

# Products Table
resource "aws_dynamodb_table" "products" {
  name         = "products"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PK"
  range_key    = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  attribute {
    name = "productId"
    type = "S"
  }

  attribute {
    name = "active"
    type = "N"
  }

  # GSI: Product lookup
  global_secondary_index {
    name            = "ProductActiveIndex"
    hash_key        = "productId"
    range_key       = "active"
    projection_type = "ALL"
  }

  # GSI: Active products
  global_secondary_index {
    name            = "ActiveIndex"
    hash_key        = "active"
    range_key       = "SK"
    projection_type = "ALL"
  }

  # Enable Point-in-Time Recovery
  point_in_time_recovery {
    enabled = true
  }

  # Enable DynamoDB Streams
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  tags = {
    Name        = "products"
    Owner       = "Platform Team"
    CostCenter  = "Engineering"
  }
}

# Campaigns Table
resource "aws_dynamodb_table" "campaigns" {
  name         = "campaigns"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "PK"
  range_key    = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  attribute {
    name = "campaignId"
    type = "S"
  }

  attribute {
    name = "productId"
    type = "S"
  }

  attribute {
    name = "active"
    type = "N"
  }

  # GSI: Campaign lookup
  global_secondary_index {
    name            = "CampaignActiveIndex"
    hash_key        = "campaignId"
    range_key       = "active"
    projection_type = "ALL"
  }

  # GSI: Product campaigns
  global_secondary_index {
    name            = "CampaignProductIndex"
    hash_key        = "productId"
    range_key       = "SK"
    projection_type = "ALL"
  }

  # GSI: Active campaigns
  global_secondary_index {
    name            = "ActiveIndex"
    hash_key        = "active"
    range_key       = "SK"
    projection_type = "ALL"
  }

  # Enable Point-in-Time Recovery
  point_in_time_recovery {
    enabled = true
  }

  # Enable DynamoDB Streams
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  tags = {
    Name        = "campaigns"
    Owner       = "Platform Team"
    CostCenter  = "Engineering"
  }
}
