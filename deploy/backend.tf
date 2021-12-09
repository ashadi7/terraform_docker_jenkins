# --- root/backend.tf ---
  
terraform {
  backend "s3" {
    bucket = "iaascode20212023"
    key    = "bastion.tfstate"
    region = "ap-southeast-2"
  }
}
