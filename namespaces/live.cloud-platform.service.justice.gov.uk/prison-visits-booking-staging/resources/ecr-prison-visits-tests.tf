module "ecr-repo-prison-visits-tests" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "prison-visits-booking"
  repo_name = "prison-visits-integration-tests"
}

resource "kubernetes_secret" "ecr-repo-prison-visits-tests" {
  metadata {
    name      = "ecr-repo-prison-visits-tests"
    namespace = var.namespace
  }

  data = {
    repo_url          = module.ecr-repo-prison-visits-tests.repo_url
    access_key_id     = module.ecr-repo-prison-visits-tests.access_key_id
    secret_access_key = module.ecr-repo-prison-visits-tests.secret_access_key
  }
}

