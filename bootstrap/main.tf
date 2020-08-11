###
# Generate randon id to append to every created resource name
###
resource "random_id" "this" {
  byte_length = 3
}

locals {
  binaries_bucket_name  = format("binaries-%s", random_id.this.hex)
  terraform_bucket_name = format("terraform-%s", random_id.this.hex)

  create_binaries_bucket  = var.existing_binaries_bucket_name == null ? true : false
  create_terraform_bucket = var.existing_terraform_bucket_name == null ? true : false

  common_labels = {
    owner       = var.owner
    environment = var.environment
  }

}