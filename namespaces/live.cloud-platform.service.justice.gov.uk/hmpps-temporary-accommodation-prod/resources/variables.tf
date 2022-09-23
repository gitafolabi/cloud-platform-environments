
variable "cluster_name" {
}

variable "vpc_name" {
}

variable "application" {
  description = "Name of Application you are deploying"
  default     = "Temporary Accommodation"
}

variable "namespace" {
  default = "hmpps-temporary-accommodation-prod"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "hmpps-temporary-accommodation"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "production"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "cas3@digital.justice.gov.uk"
}

variable "is_production" {
  default = "true"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "community-accommodation-service-tier-3-team"
}

variable "number_cache_clusters" {
  default = "2"
}
