variable "account_id" {
  type = string
}

variable "env" {
  type = string
}

variable "irsa_oidc_provider" {
  type = string
}

variable "image_server_irsa_namespace" {
  type = string
}
variable "image_server_irsa_service_account" {
  type = string
}

variable "epp_server_irsa_namespace" {
  type = string
}
variable "epp_server_irsa_service_account" {
  type = string
}

variable "import_irsa_namespace" {
  type = string
}
variable "import_irsa_service_account" {
  type = string
}

variable "biorxiv_role_arn" {
  type = string
}

variable "production_team_group_name" {
  type = string
  description = "This group name is given read-write access to the source buckets for MECAs and PDFs"
}
