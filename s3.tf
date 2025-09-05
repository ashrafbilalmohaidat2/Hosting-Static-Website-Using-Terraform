resource "aws_s3_bucket" "website-bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "s3-static-website"
    Environment = "Dev"
  }
}

# Enable website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website-bucket.bucket

  index_document {
    suffix = var.index_file
  }

  error_document {
    key = var.error_file
  }
}

# Allow public read access
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.website-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.website-bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.website-bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Upload index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website-bucket.bucket
  key          = var.index_file
  source       = "${path.module}/websiteFiles/index.html"
  content_type = "text/html"
}

# Upload error.html
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.website-bucket.bucket
  key          = var.error_file
  source       = "${path.module}/websiteFiles/error.html"
  content_type = "text/html"
}
