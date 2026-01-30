resource "aws_lb" "this" {
  name                       = var.alb_name
  internal                   = var.internal
  load_balancer_type         = "application"
  subnets                    = var.subnet_ids
  security_groups            = var.security_group_ids
  enable_deletion_protection = var.enable_deletion_protection
  drop_invalid_header_fields = var.drop_invalid_header_fields

#   dynamic "access_logs" {
#     for_each = var.access_logs == null ? [] : [var.access_logs]
#     content {
#       bucket  = access_logs.value.bucket
#       enabled = access_logs.value.enabled
#       prefix  = access_logs.value.prefix
#     }
#   }

  tags = var.tags
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    path                = var.health_check.path
    protocol            = var.health_check.protocol
    matcher             = var.health_check.matcher
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    timeout             = var.health_check.timeout
    interval            = var.health_check.interval
  }

  tags = var.tags
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTPS"

  ssl_policy      = var.ssl_policy
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  tags = var.tags
}
