# Publisher ECR Repos

module "ecr-repo-fb-publisher-base" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-publisher-base"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-publisher"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-publisher-base" {
  metadata {
    name      = "ecr-repo-fb-publisher-base"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-publisher-base.repo_url
    access_key_id     = module.ecr-repo-fb-publisher-base.access_key_id
    secret_access_key = module.ecr-repo-fb-publisher-base.secret_access_key
  }
}

module "ecr-repo-fb-publisher-web" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-publisher-web"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-publisher"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-publisher-web" {
  metadata {
    name      = "ecr-repo-fb-publisher-web"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-publisher-web.repo_url
    access_key_id     = module.ecr-repo-fb-publisher-web.access_key_id
    secret_access_key = module.ecr-repo-fb-publisher-web.secret_access_key
  }
}

module "ecr-repo-fb-publisher-worker" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-publisher-worker"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-publisher"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-publisher-worker" {
  metadata {
    name      = "ecr-repo-fb-publisher-worker"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-publisher-worker.repo_url
    access_key_id     = module.ecr-repo-fb-publisher-worker.access_key_id
    secret_access_key = module.ecr-repo-fb-publisher-worker.secret_access_key
  }
}

##################################################

# Runner Node ECR Repos
module "ecr-repo-fb-runner-node" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-runner-node"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-runner-node"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-runner-node" {
  metadata {
    name      = "ecr-repo-fb-runner-node"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-runner-node.repo_url
    access_key_id     = module.ecr-repo-fb-runner-node.access_key_id
    secret_access_key = module.ecr-repo-fb-runner-node.secret_access_key
  }
}

########################################################

# Service Token Cache ECR Repos
module "ecr-repo-fb-service-token-cache" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-service-token-cache"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-service-token-cache"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-service-token-cache" {
  metadata {
    name      = "ecr-repo-fb-service-token-cache"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-service-token-cache.repo_url
    access_key_id     = module.ecr-repo-fb-service-token-cache.access_key_id
    secret_access_key = module.ecr-repo-fb-service-token-cache.secret_access_key
  }
}

########################################################

# Submitter ECR Repos
module "ecr-repo-fb-submitter-base" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-submitter-base"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-submitter-base" {
  metadata {
    name      = "ecr-repo-fb-submitter-base"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-submitter-base.repo_url
    access_key_id     = module.ecr-repo-fb-submitter-base.access_key_id
    secret_access_key = module.ecr-repo-fb-submitter-base.secret_access_key
  }
}

module "ecr-repo-fb-submitter-api" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-submitter-api"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-submitter"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-submitter-api" {
  metadata {
    name      = "ecr-repo-fb-submitter-api"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-submitter-api.repo_url
    access_key_id     = module.ecr-repo-fb-submitter-api.access_key_id
    secret_access_key = module.ecr-repo-fb-submitter-api.secret_access_key
  }
}

module "ecr-repo-fb-submitter-workers" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-submitter-workers"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-submitter"]

  namespace = var.namespace
  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-submitter-workers" {
  metadata {
    name      = "ecr-repo-fb-submitter-workers"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-submitter-workers.repo_url
    access_key_id     = module.ecr-repo-fb-submitter-workers.access_key_id
    secret_access_key = module.ecr-repo-fb-submitter-workers.secret_access_key
  }
}

##################################################

# User Datastore ECR Repos
module "ecr-repo-fb-user-datastore-api" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-user-datastore-api"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-user-datastore"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-user-datastore-api" {
  metadata {
    name      = "ecr-repo-fb-user-datastore-api"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-user-datastore-api.repo_url
    access_key_id     = module.ecr-repo-fb-user-datastore-api.access_key_id
    secret_access_key = module.ecr-repo-fb-user-datastore-api.secret_access_key
  }
}

##################################################

# User Filestore ECR Repos
module "ecr-repo-fb-user-filestore-api" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-user-filestore-api"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-user-filestore"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-user-filestore-api" {
  metadata {
    name      = "ecr-repo-fb-user-filestore-api"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-user-filestore-api.repo_url
    access_key_id     = module.ecr-repo-fb-user-filestore-api.access_key_id
    secret_access_key = module.ecr-repo-fb-user-filestore-api.secret_access_key
  }
}

##################################################

# AV (Anti Virus) ECR Repos
module "ecr-repo-fb-av" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-av"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-av"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-av" {
  metadata {
    name      = "ecr-repo-fb-av"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-av.repo_url
    access_key_id     = module.ecr-repo-fb-av.access_key_id
    secret_access_key = module.ecr-repo-fb-av.secret_access_key
  }
}

##################################################

# fb-builder - docker image used to build form builder components
module "ecr-repo-fb-builder" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-builder"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]

  github_repositories = ["fb-builder"]
  namespace = var.namespace
  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-builder" {
  metadata {
    name      = "ecr-repo-fb-builder"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-builder.repo_url
    access_key_id     = module.ecr-repo-fb-builder.access_key_id
    secret_access_key = module.ecr-repo-fb-builder.secret_access_key
  }
}

##################################################

module "ecr-repo-fb-pdf-generator" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-pdf-generator"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-pdf-generator"]
  namespace = var.namespace

}

resource "kubernetes_secret" "ecr-repo-fb-pdf-generator" {
  metadata {
    name      = "ecr-repo-fb-pdf-generator"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-pdf-generator.repo_url
    access_key_id     = module.ecr-repo-fb-pdf-generator.access_key_id
    secret_access_key = module.ecr-repo-fb-pdf-generator.secret_access_key
  }
}

##################################################

module "ecr-repo-fb-base-adapter" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-base-adapter"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-base-adapter"]
  namespace = var.namespace
}

resource "kubernetes_secret" "ecr-repo-fb-base-adapter" {
  metadata {
    name      = "ecr-repo-fb-base-adapter"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-base-adapter.repo_url
    access_key_id     = module.ecr-repo-fb-base-adapter.access_key_id
    secret_access_key = module.ecr-repo-fb-base-adapter.secret_access_key
  }
}

##################################################

module "ecr-repo-hmcts-complaints-formbuilder-adapter-api" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "hmcts-complaints-formbuilder-adapter-api"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["hmcts-complaints-formbuilder-adapter"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-hmcts-complaints-formbuilder-adapter-api" {
  metadata {
    name      = "ecr-repo-hmcts-complaints-formbuilder-adapter-api"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-hmcts-complaints-formbuilder-adapter-api.repo_url
    access_key_id     = module.ecr-repo-hmcts-complaints-formbuilder-adapter-api.access_key_id
    secret_access_key = module.ecr-repo-hmcts-complaints-formbuilder-adapter-api.secret_access_key
  }
}

module "ecr-repo-hmcts-complaints-formbuilder-adapter-worker" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "hmcts-complaints-formbuilder-adapter-worker"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["hmcts-complaints-formbuilder-adapter"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-hmcts-complaints-formbuilder-adapter-worker" {
  metadata {
    name      = "ecr-repo-hmcts-complaints-formbuilder-adapter-worker"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-hmcts-complaints-formbuilder-adapter-worker.repo_url
    access_key_id     = module.ecr-repo-hmcts-complaints-formbuilder-adapter-worker.access_key_id
    secret_access_key = module.ecr-repo-hmcts-complaints-formbuilder-adapter-worker.secret_access_key
  }
}

##################################################

module "ecr-repo-fb-metadata-api" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-metadata-api"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-metadata-api"]
  namespace = var.namespace
}

resource "kubernetes_secret" "ecr-repo-fb-metadata-api" {
  metadata {
    name      = "ecr-repo-fb-metadata-api"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-metadata-api.repo_url
    access_key_id     = module.ecr-repo-fb-metadata-api.access_key_id
    secret_access_key = module.ecr-repo-fb-metadata-api.secret_access_key
  }
}

##################################################

module "ecr-repo-fb-editor-web" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-editor-web"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]

  github_repositories = ["fb-editor"]
  namespace = var.namespace
}

resource "kubernetes_secret" "ecr-repo-fb-editor-web" {
  metadata {
    name      = "ecr-repo-fb-editor-web"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-editor-web.repo_url
    access_key_id     = module.ecr-repo-fb-editor-web.access_key_id
    secret_access_key = module.ecr-repo-fb-editor-web.secret_access_key
  }
}

module "ecr-repo-fb-editor-workers" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-editor-workers"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]

  github_repositories = ["fb-editor"]
  namespace = var.namespace
}

resource "kubernetes_secret" "ecr-repo-fb-editor-workers" {
  metadata {
    name      = "ecr-repo-fb-editor-workers"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-editor-workers.repo_url
    access_key_id     = module.ecr-repo-fb-editor-workers.access_key_id
    secret_access_key = module.ecr-repo-fb-editor-workers.secret_access_key
  }
}
##################################################

module "ecr-repo-fb-runner" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-runner"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-runner"]
  namespace = var.namespace
}

resource "kubernetes_secret" "ecr-repo-fb-runner" {
  metadata {
    name      = "ecr-repo-fb-runner"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-runner.repo_url
    access_key_id     = module.ecr-repo-fb-runner.access_key_id
    secret_access_key = module.ecr-repo-fb-runner.secret_access_key
  }
}

##################################################

module "ecr-repo-fb-maintenance-page" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-maintenance-page"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-maintenance-page"]
  namespace = var.namespace
}

resource "kubernetes_secret" "ecr-repo-fb-maintenance-page" {
  metadata {
    name      = "ecr-repo-fb-maintenance-page"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-maintenance-page.repo_url
    access_key_id     = module.ecr-repo-fb-maintenance-page.access_key_id
    secret_access_key = module.ecr-repo-fb-maintenance-page.secret_access_key
  }
}

##################################################

module "ecr-repo-fb-adapter-template-api" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-adapter-template-api"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-adapter-template"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-adapter-template-api" {
  metadata {
    name      = "ecr-repo-fb-adapter-template-api"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-adapter-template-api.repo_url
    access_key_id     = module.ecr-repo-fb-adapter-template-api.access_key_id
    secret_access_key = module.ecr-repo-fb-adapter-template-api.secret_access_key
  }
}

module "ecr-repo-fb-adapter-template-worker" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=5.3.0"

  team_name = "formbuilder"
  repo_name = "fb-adapter-template-worker"

  scan_on_push     = var.scan_on_push
  lifecycle_policy = var.lifecycle_policy

  oidc_providers = ["circleci"]
  github_repositories = ["fb-adapter-template"]
  namespace = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "ecr-repo-fb-adapter-template-worker" {
  metadata {
    name      = "ecr-repo-fb-adapter-template-worker"
    namespace = "formbuilder-repos"
  }

  data = {
    repo_url          = module.ecr-repo-fb-adapter-template-worker.repo_url
    access_key_id     = module.ecr-repo-fb-adapter-template-worker.access_key_id
    secret_access_key = module.ecr-repo-fb-adapter-template-worker.secret_access_key
  }
}

##################################################
