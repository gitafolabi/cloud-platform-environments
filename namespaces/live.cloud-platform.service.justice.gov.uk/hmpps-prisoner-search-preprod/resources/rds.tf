module "hmpps_prisoner_search_rds" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.19.0"

  vpc_name                  = var.vpc_name
  team_name                 = var.team_name
  business-unit             = var.business_unit
  application               = var.application
  is-production             = var.is_production
  namespace                 = var.namespace
  environment-name          = var.environment
  infrastructure-support    = var.infrastructure_support
  db_instance_class         = "db.t4g.micro"
  db_engine                 = "postgres"
  db_engine_version         = "15"
  rds_family                = "postgres15"
  deletion_protection       = true
  prepare_for_major_upgrade = false
  db_max_allocated_storage  = "500"

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "hmpps_prisoner_search_rds" {
  metadata {
    name      = "rds-instance-output"
    namespace = var.namespace
  }

  data = {
    rds_instance_endpoint = module.hmpps_prisoner_search_rds.rds_instance_endpoint
    database_name         = module.hmpps_prisoner_search_rds.database_name
    database_username     = module.hmpps_prisoner_search_rds.database_username
    database_password     = module.hmpps_prisoner_search_rds.database_password
    rds_instance_address  = module.hmpps_prisoner_search_rds.rds_instance_address
  }
}
