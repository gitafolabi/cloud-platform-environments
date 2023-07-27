module "serviceaccount" {
  source              = "github.com/ministryofjustice/cloud-platform-terraform-serviceaccount?ref=0.9.6"
  serviceaccount_name = "circleci"
  namespace           = var.namespace
  kubernetes_cluster  = var.kubernetes_cluster

}
