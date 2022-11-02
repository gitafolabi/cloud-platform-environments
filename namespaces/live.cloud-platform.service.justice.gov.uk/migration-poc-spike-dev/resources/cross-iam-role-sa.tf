module "irsa" {
  eks_cluster_name = var.eks_cluster_name
  source           = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.0.5"
  namespace        = "migration-poc-spike-dev"
  role_policy_arns = [aws_iam_policy.allow_s3_access.arn]
}

data "aws_iam_policy_document" "allow_s3_access" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:aws:iam::684969100054:role/cp-app-migration-poc-dev",
    ]
  }
}

resource "aws_iam_policy" "allow_s3_access" {
  name   = "migration-poc-spike-dev-allow-s3-policy"
  policy = data.aws_iam_policy_document.allow_s3_access.json

  tags = {
    business-unit          = "Cloud Platform"
    application            = "Test Migration"
    is-production          = "false"
    environment-name       = "Development"
    owner                  = "cloud-platform"
    infrastructure-support = "platforms@digital.justice.gov.uk"
  }
}

resource "kubernetes_secret" "irsa" {
  metadata {
    name      = "irsa-output"
    namespace = "migration-poc-spike-dev"
  }
  data = {
    role           = module.irsa.aws_iam_role_arn
    serviceaccount = module.irsa.service_account_name.name
  }
}
