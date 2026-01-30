data "aws_s3_bucket" "lb_logs" {
  bucket = var.lb_logs_bucket
}


resource "aws_lb" "test" {
  name               = var.alb_name
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = data.aws_s3_bucket.lb_logs.id
    prefix  = "alb-logs"
    enabled = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.test.arn
  port              = "8080"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn =  var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip.arn
  }

}

# resource "aws_lb_listener_rule" "static" {
#   listener_arn = aws_lb_listener.this.arn
#   priority     = 100

#   action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }

#   condition {
#     http_header {
#       http_header_name = "X-Forwarded-For"
#       values           = ["192.168.1.*"]
#     }
#   }
# }

resource "aws_lb_target_group" "ip" {
  name        = var.lb_target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }
}