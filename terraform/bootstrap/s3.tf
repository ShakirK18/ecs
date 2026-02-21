resource "aws_s3_bucket" "lb_logs" {
  bucket = "shakir-alb-logs-${var.environment}"
}

resource "aws_s3_bucket_logging" "name" {
  bucket = aws_s3_bucket.lb_logs.id

  target_bucket = aws_s3_bucket.lb_logs.id
  target_prefix = "logs/"
}