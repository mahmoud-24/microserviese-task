resource "aws_sns_topic" "example" {
  name = "example"
}

resource "aws_sns_topic_policy" "example" {
  arn     = aws_sns_topic.example.arn
  policy  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SNS:Publish",
      "Resource": "arn:aws:sns:*:*:example",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:s3:*:*:*"
        }
      }
    }
  ]
}
EOF
}

# no.3
resource "aws_sns_topic" "example" {
  name = "example"
}

resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol = "email"
  endpoint = "example@example.com"
  filter_policy = {
   "type" = ["email"]
  }
}

resource "aws_s3_bucket_notification" "example" {
  bucket = aws_s3_bucket.example.bucket
  topic_arn = aws_sns_topic.example.arn

  events = ["s3:ObjectCreated:*"]
}
# events = ["s3:ObjectCreated:*"]
#   filter {
#     s3_key {
#       rules = {
#         "suffix" = ".txt"
#       }
#     }
#   }

