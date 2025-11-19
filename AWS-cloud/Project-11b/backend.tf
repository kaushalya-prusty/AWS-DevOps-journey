terraform {
  backend "s3" {
    bucket="kaushalya-tfstate-storage"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}