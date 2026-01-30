variable "oidc-role" {
  description = "Name of the OIDC role to be created" 
}

variable "repositories" {
  description = "Name of repository for OIDC trust relationship"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
}

variable "environment" {
  description = "Environment name"
}