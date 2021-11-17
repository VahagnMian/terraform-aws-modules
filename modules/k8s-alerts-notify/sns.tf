data "aws_caller_identity" "current" {
}

resource "aws_sns_topic" "route53-healthcheck" {
  display_name = "${replace(var.pod_name, ".", "-")}-slack"
  name         = "${replace(var.pod_name, ".", "-")}-slack"
  policy = jsonencode(
    {
      Id = "__default_policy_ID"
      Statement = [
        {
          Action = [
            "SNS:GetTopicAttributes",
            "SNS:SetTopicAttributes",
            "SNS:AddPermission",
            "SNS:RemovePermission",
            "SNS:DeleteTopic",
            "SNS:Subscribe",
            "SNS:ListSubscriptionsByTopic",
            "SNS:Publish",
            "SNS:Receive",
          ]
          Condition = {
            StringEquals = {
              "AWS:SourceOwner" = "${data.aws_caller_identity.current.account_id}"
            }
          }
          Effect = "Allow"
          Principal = {
            AWS = "*"
          }
          Resource = "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:${replace(var.pod_name, ".", "-")}-slack"
          Sid      = "__default_statement_ID"
        },
      ]
      Version = "2008-10-17"
    }
  )
  tags = {}
}
