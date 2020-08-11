output "binaries_bucket" {
  value = local.create_binaries_bucket ? google_storage_bucket.binaries[0].name : var.existing_binaries_bucket_name
}

output "terraform_bucket_name" {
  value = local.create_terraform_bucket ? google_storage_bucket.terraform[0].name : var.existing_terraform_bucket_name
}