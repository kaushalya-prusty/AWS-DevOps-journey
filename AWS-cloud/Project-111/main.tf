resource "aws_s3_bucket" "terraform-storage" {
  bucket= "kaushalya-tfstate-storage"
}
resource "aws_dynamodb_table" "terraform-lock" {
  name = "terraform-lock"
  hash_key ="LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name="LockID"
    type="S"
  }

}