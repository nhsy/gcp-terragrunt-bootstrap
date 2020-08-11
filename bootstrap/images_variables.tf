resource "local_file" "packer_json" {
  filename = "../images/variables.json"
  content = templatefile("../templates/packer-variables.json",
    {
      project_id      = var.project_id,
      region          = var.region
      binaries_bucket = local.create_binaries_bucket ? google_storage_bucket.binaries[0].name : var.existing_binaries_bucket_name
    }
  )
}
