terraform {
  backend "s3" {
    bucket = "terraform-state-2034016982-848525792"
    key    = "gimnasio/dev/terraform.tfstate"
    region = "us-east-1"
  }
}