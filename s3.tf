resource "aws_s3_bucket" "s3" {
    bucket = "website-backend-hosting"
    
   
  
}

resource "aws_s3_bucket_public_access_block" "public_access_policy" {
  bucket = aws_s3_bucket.s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website" {
  bucket = aws_s3_bucket.s3.id

  index_document {
    suffix = "index.html"
  }

}