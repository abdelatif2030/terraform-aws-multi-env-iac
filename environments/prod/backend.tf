terraform {
  backend "s3" {
    bucket         = "terraform-state-080777914113"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
