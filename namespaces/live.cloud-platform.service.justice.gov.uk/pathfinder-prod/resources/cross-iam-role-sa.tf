module "irsa" {
  source           = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.1.0"
  namespace        = "pathfinder-prod"
  eks_cluster_name = var.eks_cluster_name
  role_policy_arns = [aws_iam_policy.pathfinder_prod_ap_policy.arn]
  service_account  = "to-ap-s3-service-account-prod"
}

data "aws_iam_policy_document" "pathfinder_prod_ap_policy" {
  # "api" policy statements for the namespace
  # allows direct access to "landing" S3 bucket
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    resources = [
      "arn:aws:s3:::mojap-land/hmpps/pathfinder/prod/*",
    ]
  }
}

resource "aws_iam_policy" "pathfinder_prod_ap_policy" {
  name   = "pathfinder_prod_ap_policy"
  policy = data.aws_iam_policy_document.pathfinder_prod_ap_policy.json
}

resource "kubernetes_secret" "irsa" {
  metadata {
    name      = "to-ap-s3-irsa"
    namespace = "pathfinder-prod"
  }
  data = {
    role           = module.irsa.aws_iam_role_name
    serviceaccount = module.irsa.service_account_name.name
  }
}
