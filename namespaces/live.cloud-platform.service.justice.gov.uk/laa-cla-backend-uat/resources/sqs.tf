module "laa_cla_backend_uat_sqs" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.12.0"

  # Queue configuration
  sqs_name        = "cla_backend_uat_queue"
  encrypt_sqs_kms = "false"

  # Tags
  business_unit          = var.business_unit
  application            = var.application
  is_production          = var.is_production
  team_name              = var.team_name # also used for naming the queue
  namespace              = var.namespace
  environment_name       = var.environment_name
  infrastructure_support = var.infrastructure_support

  providers = {
    aws = aws.london
  }
}
resource "kubernetes_secret" "sqs" {
  metadata {
    name      = "sqs"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.laa_cla_backend_uat_sqs.access_key_id
    secret_access_key = module.laa_cla_backend_uat_sqs.secret_access_key
    # the above will not be set if existing_user_name is defined
    sqs_id   = module.laa_cla_backend_uat_sqs.sqs_id
    sqs_arn  = module.laa_cla_backend_uat_sqs.sqs_arn
    sqs_name = module.laa_cla_backend_uat_sqs.sqs_name
  }
}
