variable "application" {
  type = "string"

  default = "www"
}

variable "domain" {
  type = "string"

  default = "granturismo.world"
}

variable "env_names" {
  type = "map"

  default = {
    "stg" = "staging"
    "prd" = "prod"
  }
}

variable "env_dns_zones_prefix" {
  type = "map"

  default = {
    "stg" = "staging."
    "prd" = ""
  }
}

variable "s3_deployment_prefix" {
  type = "map"

  default = {
    "stg" = "master"
    "prd" = "v0.0.1-alpha.1"
  }
}
