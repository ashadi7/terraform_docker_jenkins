# Put TF code for bastion instance here
# Note: This may look different from the video because I left out the backend
#       configuration for simplicity.

provider "aws" {
  region = "ap-southeast-2"
  skip_credentials_validation = true
  skip_requesting_account_id = true
}
