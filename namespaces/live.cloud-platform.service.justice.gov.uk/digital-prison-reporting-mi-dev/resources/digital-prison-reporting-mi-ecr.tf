/*
 * Make sure that you use the latest version of the module by changing the
 * `ref=` value in the `source` attribute to the latest version listed on the
 * releases page of this repository.
 *
 */
module "digital_prison_reporting_mi_ecr_credentials" {
  source    = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.1.4"
  team_name = var.team_name
  repo_name = "digital-prison-reporting-mi-ecr"

  # Uncomment and provide repository names to create github actions secrets
  # containing the ECR name, AWS access key, and AWS secret key, for use in
  # github actions CI/CD pipelines
  # github_repositories = ["my-repo"]

  # list of github environments, to create the ECR secrets as environment secrets
  # https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment#environment-secrets
  # github_environments = ["my-environment"]

  # Uncomment to configure OIDC for GitHub Actions rather than using access keys
  # oidc_providers = ["github"]

  /*
  # Lifecycle_policy provides a way to automate the cleaning up of your container images by expiring images based on age or count.
  # To apply multiple rules, combined them in one policy JSON.
  # https://docs.aws.amazon.com/AmazonECR/latest/userguide/lifecycle_policy_examples.html

  lifecycle_policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire untagged images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Keep last 30 dev and staging images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["dev", "staging"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 3,
            "description": "Keep the newest 100 images and mark the rest for expiration",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 100
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
*/

}


resource "kubernetes_secret" "digital_prison_reporting_mi_ecr_credentials" {
  metadata {
    name      = "ecr-repo-digital-prison-reporting-mi"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.digital_prison_reporting_mi_ecr_credentials.access_key_id
    secret_access_key = module.digital_prison_reporting_mi_ecr_credentials.secret_access_key
    repo_arn          = module.digital_prison_reporting_mi_ecr_credentials.repo_arn
    repo_url          = module.digital_prison_reporting_mi_ecr_credentials.repo_url
  }
}