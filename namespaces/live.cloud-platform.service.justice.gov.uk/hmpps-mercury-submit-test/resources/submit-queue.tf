module "mercury_submit_queue" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.11.0"

  environment-name           = var.environment
  team_name                  = var.team_name
  infrastructure-support     = var.infrastructure_support
  application                = var.application
  sqs_name                   = "mercury_submit_queue"
  encrypt_sqs_kms            = "true"
  message_retention_seconds  = 1209600
  visibility_timeout_seconds = 120
  namespace                  = var.namespace


  redrive_policy = <<EOF
  {
    "deadLetterTargetArn": "${module.mercury_submit_dead_letter_queue.sqs_arn}","maxReceiveCount": 3
  }
  
EOF

  providers = {
    aws = aws.london
  }
}

module "mercury_submit_dead_letter_queue" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.11.0"

  environment-name       = var.environment
  team_name              = var.team_name
  infrastructure-support = var.infrastructure_support
  application            = var.application
  sqs_name               = "mercury_submit_dl_queue"
  encrypt_sqs_kms        = "true"
  namespace              = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "mercury_submit_queue" {
  metadata {
    name      = "mercury-submit-queue-instance-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.mercury_submit_queue.access_key_id
    secret_access_key = module.mercury_submit_queue.secret_access_key
    sqs_id            = module.mercury_submit_queue.sqs_id
    sqs_arn           = module.mercury_submit_queue.sqs_arn
    sqs_name          = module.mercury_submit_queue.sqs_name
  }
}

resource "kubernetes_secret" "mercury_submit_dead_letter_queue" {
  metadata {
    name      = "mercury-submit-dlq-instance-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.mercury_submit_dead_letter_queue.access_key_id
    secret_access_key = module.mercury_submit_dead_letter_queue.secret_access_key
    sqs_id            = module.mercury_submit_dead_letter_queue.sqs_id
    sqs_arn           = module.mercury_submit_dead_letter_queue.sqs_arn
    sqs_name          = module.mercury_submit_dead_letter_queue.sqs_name
  }
}
