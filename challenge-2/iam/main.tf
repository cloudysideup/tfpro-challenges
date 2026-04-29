resource "aws_iam_role" "test_role" {
  name               = var.iam_role_name
  assume_role_policy = var.iam_role_assume_policy
}

resource "aws_iam_instance_profile" "test_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.test_role.name
}

resource "aws_iam_user" "lb" {
  count = 3
  name  = "${var.iam_user_name}-${count.index}"
}

# This policy must be associated with all IAM users created through this code.

resource "aws_iam_user_policy" "lb_ro" {
  name  = "ec2-describe-policy"
  count = 3
  user  = aws_iam_user.lb[count.index].name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
