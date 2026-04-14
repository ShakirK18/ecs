resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.lb_log_bucket}-${var.environment}"
}