variable "image_desc" {
  description = "CentOS 7.9 (2024.08.20)"
  type        = string
  default     = "CentOS 7.9 (2024.08.20)"
}

variable "nhn_user_name" {
  description = "nhncloud 계정 아이디"
  type        = string
  default     = "nhncloud 계정 아이디"
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - 테넌트 ID
variable "api_tenant_id" {
  description = "복사한 테넌트 ID"
  type        = string
  default     = "복사한 테넌트 ID"
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - API 비밀번호 설정
variable "api_password" {
  description = "설정한 비밀번호"
  type        = string
  default     = "설정한 비밀번호"
}

variable "api_identity" {
  description = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  type        = string
  default     = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
}

variable "web-ig" {
  description = "ee297c79-d9bd-417c-a4f7-758b19a58615"
  type        = string
  default     = "ee297c79-d9bd-417c-a4f7-758b19a58615"
}
