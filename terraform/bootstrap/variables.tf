variable "oidc-role" {
  description = "Name of the OIDC role to be created"
  type        = string
}

variable "repositories" {
  description = "Name of repository for OIDC trust relationship"
  type        = list(string)
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}