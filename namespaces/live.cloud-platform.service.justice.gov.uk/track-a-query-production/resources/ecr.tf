/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */
module "track_a_query_ecr_credentials" {
  source    = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"
  repo_name = "track-a-query-ecr" # Arbitrary module name does not need to reference any existing modules
  team_name = var.team_name

  providers = {
    aws = aws.london
  }

  github_repositories = [var.repo_name]
  oidc_providers = ["circleci"]
  namespace = var.namespace

  lifecycle_policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep the newest 50 images and mark the rest for expiration",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": 50
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}

resource "kubernetes_secret" "track_a_query_ecr_credentials" {
  metadata {
    name      = "track-a-query-ecr-credentials-output"
    namespace = var.namespace
  }

  data = {
    repo_arn          = module.track_a_query_ecr_credentials.repo_arn
    repo_url          = module.track_a_query_ecr_credentials.repo_url
  }
}
