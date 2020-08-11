###
# Disabled until modules support count functionality
###

//module "gcs_binaries_bucket" {
//  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
//  version = "~> 1.6"
//
//  name          = local.gcs_binaries_bucket_name
//  project_id    = var.project_id
//  location      = var.region
//  versioning    = true
//  force_destroy = true
//}
//
//module "gcs_terraform_bucket" {
//  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
//  version = "~> 1.6"
//
//  name          = local.gcs_terraform_bucket_name
//  project_id    = var.project_id
//  location      = var.region
//  versioning    = true
//  force_destroy = true
//}

###
# Create GCS bucket for binaries
###
resource "google_storage_bucket" "binaries" {
  count              = local.create_binaries_bucket ? 1 : 0
  name               = local.binaries_bucket_name
  bucket_policy_only = true
  force_destroy      = true
  labels             = local.common_labels
  location           = var.region

  versioning {
    enabled = true
  }
  depends_on = [module.project_services]
}

###
# Create GCS bucket for terraform state
###
resource "google_storage_bucket" "terraform" {
  count              = local.create_terraform_bucket ? 1 : 0
  name               = local.terraform_bucket_name
  bucket_policy_only = true
  force_destroy      = true
  labels             = local.common_labels
  location           = var.region

  versioning {
    enabled = true
  }
  depends_on = [module.project_services]
}
