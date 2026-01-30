module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "7.3.0"

  cluster_name = var.cluster_name

  cluster_capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy = {
    FARGATE = {
      weight = 50
      base   = 20
    }
    FARGATE_SPOT = {
      weight = 50
    }
  }

  tags = {
    Environment = var.environment
  }
}

# module "ecs_service" {

#   source  = "terraform-aws-modules/ecs/aws//modules/service"
#   name    = var.service_name
#   version = "7.3.0"

#   create_security_group = false
#   cluster_arn           = module.ecs.cluster_arn

#   enable_autoscaling     = false
#   enable_execute_command = true

#   cpu    = 4096
#   memory = 8192

#   desired_count = var.desired_count

#   container_definitions = {
#     "shgw-${var.environment}" = {
#       cpu                      = 4096
#       memory                   = 8192
#       essential                = true
#       readonly_root_filesystem = false
#       image                    = var.image_name

#       create_task_exec_iam_role = false

#       port_mappings = [
#         {
#           "name" : var.container_name,
#           "containerPort" : 8080,
#           "hostPort" : 8080,
#           "protocol" : "tcp",
#           "appProtocol" : "http"
#         }
#       ]
#     }
#   }

#   load_balancer = [
#     {
#       target_group_arn = aws_lb_target_group.external-alb-tg.arn
#       container_name   = var.container_name
#       container_port   = 8080
#     },
#   ]

#   subnet_ids         = module.vpc.private_subnets
#   security_group_ids = [aws_security_group.ecs-tasks-sg.id]
# }