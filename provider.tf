# Define required providers
terraform {
required_version = ">= 1.0.0"
  required_providers {
    nhncloud = {
      source  = "terraform.local/local/nhncloud"
      version = "1.0.2"
    }
  }
}

provider "nhncloud" {
  user_name   = "resource_adm"
  tenant_id   = " "
  password    = "nhncloud"
  auth_url    = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  region      = " "
}
