# ------------------------
# S3 Bucket
# ------------------------
resource "aws_s3_bucket" "name" {
  bucket = "hgcghxhgxsxcshxsxs"

  tags = {
    Name = "depends-s3-bucket"
  }
}

# ------------------------
# EC2 Instance (depends on S3 bucket)
# ------------------------
resource "aws_instance" "name" {
  instance_type = "t3.micro"
  ami           = "ami-0bdd88bd06d16ba03"

  tags = {
    Name = "prod"
  }

  # 👇 Ensure EC2 instance is created only after the S3 bucket exists
  depends_on = [aws_s3_bucket.name]
}
