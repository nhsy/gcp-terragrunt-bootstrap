# Include all settings from the root terragrunt.hcl file
include {
    path = find_in_parent_folders()
}

# These are the input variables we have to pass in
inputs = {
  project_id  = "citrix-sandbox-proj"
  region      = "europe-west2"
  unique_id   = "0001"
  target_name_server_addresses = ["10.0.0.2", "10.1.0.2"]
  dns_zone_name = "devopcorner-com"
  dns_domain    = "devopcorner.com."
  source_service_accounts = ["org-terraform@example-project-1234.iam.gserviceaccount.com"]
  target_service_accounts = ["org-terraform@example-project-1234.iam.gserviceaccount.com"]
}