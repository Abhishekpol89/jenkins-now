resource "aws_s3_bucket" "teraa-abhi-25" {
    bucket = "${var.cloud_env}-${var.bucket_name}"
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
 bucket = aws_s3_bucket.teraa-abhi-25.id
 versioning_configuration {
 status = "Enabled"
 }
}
