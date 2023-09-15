terraform {
  backend "s3" {
    bucket = "vargas-terraform-tfstate"
    key    = "tfstate_prod"
    region = "us-east-1"
  }
}