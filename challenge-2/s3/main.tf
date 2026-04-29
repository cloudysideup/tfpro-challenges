resource "aws_s3_bucket" "example" {
  bucket = var.bucket
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = var.key
}
