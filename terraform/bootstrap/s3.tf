resource "aws_s3_bucket" "lb_logs" {
  bucket = "shakir-alb-logs-${var.environment}"
}