variable "team_name" {
  default = "webops"
}

variable "application" {
  default = "dstest"
}

variable "namespace" {
  default = "dstest"
}

variable "is-production" {
  default = "false"
}

variable "business-unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "MoJ Digital"
}

variable "application" {
  default = "RDS Module Test"
}

variable "environment-name" {
  default = "development"
}

variable "infrastructure-support" {
  default = "platforms@digital.justice.gov.uk"
}

variable "cluster_name" {
}

variable "cluster_state_bucket" {
}
