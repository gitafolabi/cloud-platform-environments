module "serviceaccount" {
  source              = "github.com/ministryofjustice/cloud-platform-terraform-serviceaccount?ref=0.7.5"
  serviceaccount_name = "circleci"
  namespace           = var.namespace
  kubernetes_cluster  = var.kubernetes_cluster

}
