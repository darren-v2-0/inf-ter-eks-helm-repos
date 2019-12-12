terraform {
  backend "s3" {
    region         = "eu-west-2"
    bucket         = "ecloud-terraform-state-coreinfra"
    key            = "helm/eu-west-1/terraform.tfstate"
  }
}
