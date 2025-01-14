module "rds-instance" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.19.0"

  vpc_name = var.vpc_name

  application            = var.application
  environment-name       = var.environment-name
  is-production          = var.is_production
  namespace              = var.namespace
  infrastructure-support = var.infrastructure_support
  team_name              = var.team_name

  backup_window      = var.backup_window
  maintenance_window = var.maintenance_window

  db_instance_class = "db.t4g.small"
  db_parameter      = [{ name = "rds.force_ssl", value = "0", apply_method = "immediate" }]
  db_engine         = "postgres"
  db_engine_version = "12.14"
  rds_family        = "postgres12"

  # use "allow_major_version_upgrade" when upgrading the major version of an engine
  allow_minor_version_upgrade = "false"
  allow_major_version_upgrade = "false"


  providers = {
    # Can be either "aws.london" or "aws.ireland"
    aws = aws.london
  }
}

resource "kubernetes_secret" "rds-instance" {
  metadata {
    name      = "rds-instance-hmpps-book-secure-move-api-${var.environment-name}"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.rds-instance.access_key_id
    secret_access_key = module.rds-instance.secret_access_key
    url               = "postgres://${module.rds-instance.database_username}:${module.rds-instance.database_password}@${module.rds-instance.rds_instance_endpoint}/${module.rds-instance.database_name}"
  }
}
