terraform {
  backend "s3" {
    bucket = "wordpress-232024"
    key    = "devops-project-1/terraform.tfstate"
    region = "eu-west-2"
  }
}