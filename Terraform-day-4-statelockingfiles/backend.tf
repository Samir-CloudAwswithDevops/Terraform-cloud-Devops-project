terraform {
  backend "s3" {
    bucket = "terraform-bucketwww"   # your actual bucket name
    key    = "day-4 locking files terraform.tfstate"
    region = "us-east-1"
  }
}