
resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol = "sqs"
  endpoint = module.sqs.sqs_queue_arn
}

