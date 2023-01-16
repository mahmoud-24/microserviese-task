resource "aws_sqs_queue" "first_queue" {
  name = "My-first-Queue"
  visibility_timeout_seconds = 15
    redrive_policy    = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount    = 5
  })
}

resource "aws_sqs_queue" "secound_queue" {
  name = "My-secound-Queue"
  visibility_timeout_seconds = 15
    redrive_policy    = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount    = 5
  })

}

resource "aws_sqs_queue" "dead_letter_queue" {
  name              = "dead-letter-queue"
  visibility_timeout_seconds = 300
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.first_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.first_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.sns-s3.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue_policy" "test2" {
  queue_url = aws_sqs_queue.secound_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "Secound",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.secound_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.sns-s3.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sns_topic_subscription" "first_sqs_target" {

  topic_arn = aws_sns_topic.sns-s3.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.first_queue.arn
}

resource "aws_sns_topic_subscription" "secound_sqs_target" {

  topic_arn = aws_sns_topic.sns-s3.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.secound_queue.arn
}

