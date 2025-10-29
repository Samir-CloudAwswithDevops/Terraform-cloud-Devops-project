terraform {
  backend "s3" {
    bucket = "terraform-bucketwww"   # your actual bucket name
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
