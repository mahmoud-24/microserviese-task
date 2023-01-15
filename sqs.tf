module "sqs" {
  source = "../helpers/sqs"
  service_name = "example"
  create_dlq = false
  visibility_timeout_seconds = 60
  max_receive_count = 2
}

module "sqs" {
  source = "../helpers/sqs"
  service_name = "example"
  create_dlq = true
  visibility_timeout_seconds = 60
}