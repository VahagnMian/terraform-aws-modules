locals {
  action = var.type == "read-only" ? local.read_only_action : var.type == "admin-access" ? local.admin_access_action : var.type == "other" ? var.policy_action : []

  admin_access_action = ["*"]
  read_only_action = [
    "aws-portal:ViewBilling",
    "aws-portal:ViewUsage",
    "autoscaling:Describe*",
    "cloudformation:DescribeStacks",
    "cloudformation:DescribeStackEvents",
    "cloudformation:DescribeStackResources",
    "cloudformation:GetTemplate",
    "cloudfront:Get*",
    "cloudfront:List*",
    "cloudwatch:Describe*",
    "cloudwatch:Get*",
    "cloudwatch:List*",
    "dynamodb:GetItem",
    "dynamodb:BatchGetItem",
    "dynamodb:Query",
    "dynamodb:Scan",
    "dynamodb:DescribeTable",
    "dynamodb:ListTables",
    "ec2:Describe*",
    "elasticache:Describe*",
    "elasticbeanstalk:Check*",
    "elasticbeanstalk:Describe*",
    "elasticbeanstalk:List*",
    "elasticbeanstalk:RequestEnvironmentInfo",
    "elasticbeanstalk:RetrieveEnvironmentInfo",
    "elasticloadbalancing:Describe*",
    "iam:List*",
    "iam:Get*",
    "route53:Get*",
    "route53:List*",
    "rds:Describe*",
    "s3:Get*",
    "s3:List*",
    "sdb:GetAttributes",
    "sdb:List*",
    "sdb:Select*",
    "ses:Get*",
    "ses:List*",
    "sns:Get*",
    "sns:List*",
    "sqs:GetQueueAttributes",
    "sqs:ListQueues",
    "sqs:ReceiveMessage",
    "storagegateway:List*",
    "storagegateway:Describe*"
  ]
}

resource "aws_iam_group_policy" "this" {
  name  = var.name
  group = aws_iam_group.this.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = local.action
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group" "this" {
  name = var.name
}

resource "aws_iam_group_membership" "this" {
  name  = var.name
  users = var.users
  group = aws_iam_group.this.name
}
