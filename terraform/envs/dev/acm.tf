# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 4.0"

#   domain_name  = "shakir-test.com"
#   zone_id      = "Z2ES7B9AZ6SHAE"

#   validation_method = "DNS"

#   wait_for_validation = true

#   tags = {
#     Environment = var.environment
#   }
# }
