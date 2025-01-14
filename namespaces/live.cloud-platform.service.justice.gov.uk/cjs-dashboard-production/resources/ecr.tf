/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */
module "ecr_credentials" {
  source                               = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"
  team_name                            = var.team_name
  repo_name                            = "${var.namespace}-ecr"
  github_repositories                  = ["cjs_scorecard_exploratory_analysis"]
  github_actions_secret_ecr_name       = var.github_actions_secret_ecr_name
  github_actions_secret_ecr_url        = var.github_actions_secret_ecr_url
  github_actions_secret_ecr_access_key = var.github_actions_secret_ecr_access_key
  github_actions_secret_ecr_secret_key = var.github_actions_secret_ecr_secret_key
  oidc_providers                       = ["github"]
  github_actions_prefix                = "prod"
}


resource "kubernetes_secret" "ecr_credentials" {
  metadata {
    name      = "ecr-repo-${var.namespace}"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.ecr_credentials.access_key_id
    secret_access_key = module.ecr_credentials.secret_access_key
    repo_arn          = module.ecr_credentials.repo_arn
    repo_url          = module.ecr_credentials.repo_url
  }
}
