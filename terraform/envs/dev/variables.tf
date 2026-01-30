variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "ECS Cluster name"
  type        = string
}

# variable "service_name" {
#   description = "ECS Service name"
#   type        = string
# }

variable "desired_count" {
  description = "Desired count of tasks"
  type        = number
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "lb_target_group_name" {
    description = "ALB Target Group"
    type = string
}

variable "lb_logs_bucket" {
  description = "Name of the S3 bucket for ALB logs"
  type        = string
}
