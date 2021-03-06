terraform {
  required_version = "~> 0.12.7"

  backend "s3" {
    key = "tf-granturismo_world"

    bucket         = "veberarnaud-terraform-states"
    dynamodb_table = "veberarnaud-terraform-locks"
  }
}

provider "aws" {
  alias = "default"

  region = "us-east-1"

  version = "~> 2.25.0"
}
