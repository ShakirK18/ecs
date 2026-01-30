variable "alb_name" {
  description = "Name of the ALB."
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal (true) or internet-facing (false)."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Subnet IDs for the ALB (typically public subnets for external ALB)."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs attached to the ALB."
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled."
  type        = bool
  default     = true
}

variable "drop_invalid_header_fields" {
  description = "Whether to drop invalid header fields."
  type        = bool
  default     = true
}

# variable "access_logs" {
#   description = "Access logs configuration. Null disables access logs."
#   type = object({
#     bucket  = string
#     enabled = bool
#     prefix  = optional(string)
#   })
#   default = null
# }

variable "vpc_id" {
  description = "VPC ID for the target group."
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group."
  type        = string
}

variable "target_group_port" {
  description = "Port the target group receives traffic on (container port)."
  type        = number
  default     = 8080
}

variable "target_group_protocol" {
  description = "Protocol for the target group."
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Target type. Use ip for Fargate."
  type        = string
  default     = "ip"
}

variable "health_check" {
  description = "Health check settings for the target group."
  type = object({
    path                = string
    protocol            = string
    matcher             = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
  })

  default = {
    path                = "/status-0123456789abcdef"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 60
  }
}

variable "listener_port" {
  description = "HTTPS listener port."
  type        = number
  default     = 443
}

variable "ssl_policy" {
  description = "SSL policy for the HTTPS listener."
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener."
  type        = string
}

variable "tags" {
  description = "Tags applied to created resources."
  type        = map(string)
  default     = {}
}
