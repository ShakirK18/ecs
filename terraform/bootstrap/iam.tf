resource "aws_iam_policy" "admin" {
    name        = "AdminPolicy"
    description = "Administrator access policy"
    
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action   = "*"
            Effect   = "Allow"
            Resource = "*"
        }
        ]
    })
}