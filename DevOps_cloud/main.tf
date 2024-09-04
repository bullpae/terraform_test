module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "devops-vpc" 
  vpc_cidr_block = "10.0.0.0/16"
}