terraform {
  backend "s3" {
    bucket         = "terraform-bucketwww"   # Your actual S3 bucket name
    key            = "day-4/terraform.tfstate"          # Path inside the bucket
    region         = "us-east-1"                       # S3 region
    dynamodb_table = "samir"                            # DynamoDB table for state locking
    encrypt        = true                              # Encrypt state file in S3
  }
}
