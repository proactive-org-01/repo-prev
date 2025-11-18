resource "aws_s3_bucket" "bucket" {
  bucket = "sneha-demo-bucket-terraform"
tags = {
    X-CS-Account       = "547045142213"
    X-CS-Region        = "us-east-1"
    Owner              = "sneha"
    Reason             = "template"
    Environment        = "test"
  }
  }

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
