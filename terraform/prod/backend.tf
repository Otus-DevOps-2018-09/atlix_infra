terraform {
  backend "gcs" {
    bucket = "atlix-terraform-backend"
    prefix = "terraform/tfstate/prod"
  }
}
