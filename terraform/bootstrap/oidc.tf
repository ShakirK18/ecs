module "github-oidc-provider" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "2.2.1"

  create_oidc_provider = true
  create_oidc_role     = true

  role_name = var.oidc-role

  repositories              = var.repositories
  oidc_role_attach_policies = [aws_iam_policy.admin.arn]

  tags = {
    "Terraform" = "true"
  }
}