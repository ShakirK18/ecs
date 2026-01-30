resource "aws_security_group" "ecs_tasks" {
    name        = "ecs-tasks-sg-${var.environment}"
    description = "Security group for ECS tasks"
    vpc_id      = module.vpc.vpc_id
    
    ingress {
        description = "Allow traffic from ALB"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        security_groups = [aws_security_group.alb-sg.id]
    }
    
    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "alb" {
  name        = "alb-sg-${var.environment}"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}