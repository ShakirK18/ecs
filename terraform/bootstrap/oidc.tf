# module "github-oidc-provider" {
#   source  = "terraform-module/github-oidc-provider/aws"
#   version = "2.2.1"

#   create_oidc_provider = true
#   create_oidc_role     = true

#   role_name = var.oidc-role

#   repositories              = var.repositories
#   oidc_role_attach_policies = [aws_iam_policy.admin.arn]

#   tags = {
#     "Terraform" = "true"
#   }
# }

resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}

data "aws_iam_policy_document" "oidc" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    condition {
      test     = "StringLike"
      values   = var.repositories
      variable = "token.actions.githubusercontent.com:sub"
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.oidc-role
  assume_role_policy = data.aws_iam_policy_document.oidc.json
}

resource "aws_iam_role_policy_attachment" "full_access" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.admin.arn
}