variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "owner" {
  type = string
}

variable "environment" {
  type    = string
  default = "development"
}

variable "existing_binaries_bucket_name" {
  type    = string
  default = null
}

variable "existing_terraform_bucket_name" {
  type    = string
  default = null
}