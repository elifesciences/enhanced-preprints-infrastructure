variable "account_id" {
  type = string
}

variable "env" {
  type = string
}

variable "irsa_oidc_provider" {
  type = string
}

variable "read_write_irsa_namespace" {
  type = string
}
variable "read_write_irsa_service_account" {
  type = string
}

variable "image_server_irsa_namespace" {
  type = string
}
variable "image_server_irsa_service_account" {
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
