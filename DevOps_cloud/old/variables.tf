variable "image_desc" {
  description = "Rocky Linux 8.10 (2024.08.20)"
  type        = string
  default     = "Rocky Linux 8.10 (2024.08.20)"
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