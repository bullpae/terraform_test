# Define required providers
terraform {
required_version = ">= 1.0.0"
  required_providers {
    nhncloud = {
      # source  = "terraform.local/local/nhncloud"
      source  = "nhn-cloud/nhncloud"
      version = "1.0.3"
    }
  }
}

provider "nhncloud" {
  user_name   = var.nhn_user_name
  tenant_id   = var.api_tenant_id
  password    = var.api_password
  auth_url    = var.api_identity
  region      = "KR1"
}
