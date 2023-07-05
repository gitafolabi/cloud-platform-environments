resource "aws_sns_topic_subscription" "prison-to-probation-update-queue-subscription" {
  topic_arn = data.aws_sns_topic.prison-offender-events.arn
  protocol  = "sqs"
  endpoint  = module.prison-to-probation-update-queue.sqs_arn
  filter_policy = jsonencode({
    eventType = [
      "BOOKING_NUMBER-CHANGED",
      "CONFIRMED_RELEASE_DATE-CHANGED",
      "EXTERNAL_MOVEMENT_RECORD-INSERTED",
      "IMPRISONMENT_STATUS-CHANGED",
      "SENTENCE_DATES-CHANGED",
    ]
  })
}

module "prison-to-probation-update-queue" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.11.0"
  namespace              = var.namespace
  team_name              = var.team_name
  environment-name       = var.environment
  infrastructure-support = var.infrastructure_support

  application = "prison-to-probation-update"
  sqs_name    = "prison-to-probation-update-queue"

  redrive_policy = jsonencode({
    deadLetterTargetArn = module.prison-to-probation-update-dlq.sqs_arn
    maxReceiveCount     = 3
  })
}

resource "aws_sqs_queue_policy" "prison-to-probation-update-queue-policy" {
  queue_url = module.prison-to-probation-update-queue.sqs_id
  policy    = data.aws_iam_policy_document.sqs_queue_policy_document.json
}

module "prison-to-probation-update-dlq" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.11.0"
  namespace              = var.namespace
  team_name              = var.team_name
  environment-name       = var.environment
  infrastructure-support = var.infrastructure_support

  application               = "prison-to-probation-update"
  sqs_name                  = "prison-to-probation-update-dlq"
}

resource "kubernetes_secret" "prison-to-probation-update-queue-secret" {
  metadata {
    name      = "prison-to-probation-update-queue"
    namespace = var.namespace
  }
  data = {
    QUEUE_NAME            = module.prison-to-probation-update-queue.sqs_name
    AWS_ACCESS_KEY_ID     = module.prison-to-probation-update-queue.access_key_id
    AWS_SECRET_ACCESS_KEY = module.prison-to-probation-update-queue.secret_access_key
  }
}

resource "kubernetes_secret" "prison-to-probation-update-dlq-secret" {
  metadata {
    name      = "prison-to-probation-update-dlq"
    namespace = var.namespace
  }
  data = {
    QUEUE_NAME            = module.prison-to-probation-update-dlq.sqs_name
    AWS_ACCESS_KEY_ID     = module.prison-to-probation-update-dlq.access_key_id
    AWS_SECRET_ACCESS_KEY = module.prison-to-probation-update-dlq.secret_access_key
  }
}

data "aws_iam_policy_document" "sqs_queue_policy_document" {
  statement {
    sid     = "ProbationOffenderEventsToQueue"
    effect  = "Allow"
    actions = ["sqs:SendMessage"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    condition {
      variable = "aws:SourceArn"
      test     = "ArnEquals"
      values   = [data.aws_sns_topic.prison-offender-events.arn]
    }
    resources = ["*"]
  }
}