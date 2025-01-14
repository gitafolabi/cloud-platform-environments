#####################################
# Disclosure Checker ECR repository
#####################################

module "ecr-repo" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = var.team_name
  repo_name = var.repo_name

  github_repositories = [var.repo_name]

  # enable the oidc implementation for GitHub
  oidc_providers = ["github"]

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

resource "kubernetes_secret" "ecr-repo" {
  metadata {
    name      = "ecr-repo-${var.repo_name}"
    namespace = var.namespace
  }

  data = {
    repo_url          = module.ecr-repo.repo_url
    repo_arn          = module.ecr-repo.repo_arn
  }
}
