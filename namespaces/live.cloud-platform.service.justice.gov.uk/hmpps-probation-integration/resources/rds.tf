module "flipt-db" {
  source                       = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.17.0"
  vpc_name                     = var.vpc_name
  team_name                    = var.team_name
  business-unit                = var.business_unit
  application                  = var.application
  is-production                = var.is_production
  environment-name             = var.environment
  infrastructure-support       = var.infrastructure_support
  namespace                    = var.namespace
  rds_name                     = "probation-integration-flipt-db"
  rds_family                   = "postgres14"
  db_engine_version            = "14"
  db_instance_class            = "db.t4g.small"
  allow_major_version_upgrade  = false
  performance_insights_enabled = true
}

resource "kubernetes_secret" "flipt-db" {
  metadata {
    name      = "flipt-db"
    namespace = var.namespace
  }
  data = {
    URL = "postgres://${module.flipt-db.database_username}:${module.flipt-db.database_password}@${module.flipt-db.rds_instance_endpoint}/${module.flipt-db.database_name}"
  }
}
