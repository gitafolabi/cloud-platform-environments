
variable "cluster_name" {
}

variable "vpc_name" {
}


variable "application" {
  description = "Name of Application you are deploying"
  default     = "Assess risks and needs"
}

variable "namespace" {
  default = "hmpps-assessments-dev"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "hmpps-assessments"
}

variable "environment_name" {
  description = "The type of environment you're deploying to."
  default     = "development"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "assess-risks-and-needs@digital.justice.gov.uk"
}

variable "is_production" {
  default = "false"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "hmpps-assessments-dev"
}

variable "rds_family" {
  default = "postgres10"
}

variable "domain" {
  default = "hmpps-assessments.service.justice.gov.uk"
}



# DEPRECATED: snake-case variables are the default. The definitions below
# have been left in place until all code has been updated to use snake-case
# variable names.

variable "business-unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HMPPS"
}

variable "team-name" {
  description = "The name of your development team"
  default     = "hmpps-assessments"
}

variable "infrastructure-support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "assess-risks-and-needs@digital.justice.gov.uk"
}

variable "is-production" {
  default = "false"
}

variable "slack-channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "hmpps-assessments-dev"
}

variable "rds-family" {
  default = "postgres10"
}

