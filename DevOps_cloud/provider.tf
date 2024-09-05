# Define required providers
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    nhncloud = {
      # source  = "terraform.local/local/nhncloud"
      source  = "nhn-cloud/nhncloud"
      version = "1.0.2"
    }
  }
}

provider "nhncloud" {
  user_name = var.nhn_user_name
  tenant_id = var.api_tenant_id
  password  = var.api_password
  auth_url  = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  region    = "KR1"
}

variable "nhn_user_name" {
  description = "nhncloud account"
  type        = string
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - 테넌트 ID
variable "api_tenant_id" {
  description = "Tenant ID"
  type        = string
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - API 비밀번호 설정
variable "api_password" {
  description = "API Password"
  type        = string
}
