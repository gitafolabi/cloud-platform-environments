module "dps_redis" {
  source                  = "github.com/ministryofjustice/cloud-platform-terraform-elasticache-cluster?ref=6.2.0"
  vpc_name                = var.vpc_name
  application             = var.application
  environment-name        = var.environment-name
  is-production           = var.is_production
  infrastructure-support  = var.infrastructure_support
  team_name               = var.team_name
  business-unit           = var.business_unit
  number_cache_clusters   = var.number_cache_clusters
  node_type               = "cache.t4g.micro"
  engine_version          = "7.0"
  parameter_group_name    = "default.redis7"
  namespace               = var.namespace
  auth_token_rotated_date = "2023-07-13"

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "dps_redis" {
  metadata {
    name      = "dps-redis"
    namespace = var.namespace
  }

  data = {
    REDIS_HOST      = module.dps_redis.primary_endpoint_address
    REDIS_PASSWORD  = module.dps_redis.auth_token
    member_clusters = jsonencode(module.dps_redis.member_clusters)
  }
}
