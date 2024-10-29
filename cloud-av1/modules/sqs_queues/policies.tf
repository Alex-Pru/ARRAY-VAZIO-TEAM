resource "aws_sqs_queue_policy" "sqs_notifications_queue_policy" {
  queue_url = aws_sqs_queue.sqs_notifications_queue.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sns.amazonaws.com"
        },
        Action    = "SQS:SendMessage",
        Resource  = aws_sqs_queue.sqs_notifications_queue.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = var.sns_topic_id
          }
        }
      }
    ]
  })
}