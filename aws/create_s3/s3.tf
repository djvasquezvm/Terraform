resource "aws_s3_bucket" "prueba_bucket_daniel_vasquez" {
  bucket = "prueba_bucket_daniel_vasquez"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "Prueba bucket daniel vasquez"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.prueba_bucket_daniel_vasquez.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
