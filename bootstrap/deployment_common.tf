###
# Copy terragrunt.hcl to deployment folder
###
resource "local_file" "terragrunt_hcl" {
  filename = "../deployment/terragrunt.hcl"
  content = templatefile("../templates/terragrunt.hcl",
    {
      project_id       = var.project_id,
      region           = var.region
      terraform_bucket = local.create_terraform_bucket ? google_storage_bucket.terraform[0].name : var.existing_terraform_bucket_name
    }
  )
}

###
# Copy common-var.tf to each layer in deployment folder
###
resource "local_file" "common_tf" {
  for_each = toset([
    "../deployment/01-common/common_vars.tf",
    "../deployment/02-network/common_vars.tf"
  ])
  filename = each.value
  content = templatefile("../templates/common_vars.tf",
    {
      project_id = var.project_id,
      region     = var.region
    }
  )
}

###
# Copy common.auto.tfvars to each layer in deployment folder
###
resource "local_file" "common_tfvars" {
  for_each = toset([
    "../deployment/01-common/common.auto.tfvars",
    "../deployment/02-network/common.auto.tfvars"
  ])
  filename = each.value
  content = templatefile("../templates/common.auto.tfvars",
    {
      environment = var.environment
      owner       = var.owner
      project_id  = var.project_id,
      region      = var.region
    }
  )
}
