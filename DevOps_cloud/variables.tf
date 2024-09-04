variable "image_desc" {
  description = "Rocky Linux 8.10 (2024.08.20)"
  type        = string
  default     = "Rocky Linux 8.10 (2024.08.20)"
}

variable "nhn_user_name" {
  description = "nhncloud 계정 아이디"
  type        = string
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - 테넌트 ID
variable "api_tenant_id" {
  description = "복사한 테넌트 ID"
  type        = string
}

# Compute - Instance - API 엔드포인트 - API 엔드포인트 설정 - API 비밀번호 설정
variable "api_password" {
  description = "설정한 비밀번호"
  type        = string
}

variable "api_identity" {
  description = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  type        = string
  default     = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
}

variable "subnet_zones" {
  type    = list(string)
  default = ["devpos", "test"]
}

variable "sg_sg_rules" {
  type = list(object({
    sg_name    = string
    sg_rules = list(object({
      name        = string
      description = string
      ethertype   = string
      direction   = string
      from_port   = string
      to_port     = string
      protocol    = string
      cidr_blocks = string
    }))
  }))

  default = [ {
    sg_name = "devops-sg"
    sg_rules = [ {
      name        = "http"
      description = "http"
      ethertype   = "IPv4"
      direction   = "ingress"
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }, 
    {
      name        = "ssh"
      description = "ssh"
      ethertype   = "IPv4"
      direction   = "ingress"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    } ]
  },
  {
    sg_name = "test-sg"
    sg_rules = [ {
      name        = "http"
      description = "http"
      ethertype   = "IPv4"
      direction   = "ingress"
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }, 
    {
      name        = "ssh"
      description = "ssh"
      ethertype   = "IPv4"
      direction   = "ingress"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }]
  } ] 
  
}