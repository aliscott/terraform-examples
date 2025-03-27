provider "google" {
  project = var.project_id
  region  = var.region
}

module "cloud_storage" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 3.4"

  project_id  = var.project_id
  names       = var.bucket_names
  prefix      = var.prefix
  location    = var.location
  versioning  = var.enable_versioning
  labels      = var.labels
  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age        = var.lifecycle_age_days
      with_state = "ANY"
    }
  }]
}

# Example Cloud Function to demonstrate storage triggers
data "archive_file" "source" {
  type        = "zip"
  output_path = "/tmp/function-source.zip"
  source_dir  = "${path.module}/functions/hello-world"
}

resource "google_storage_bucket" "function_bucket" {
  name     = "${var.prefix}-functions"
  location = var.location
  labels   = var.labels

  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "function_code" {
  name   = "function-source.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = data.archive_file.source.output_path

  metadata = {
    hash = data.archive_file.source.output_md5
  }
}

module "cloud_function" {
  source  = "terraform-google-modules/cloudfunctions/google"
  version = "~> 0.5"

  project_id        = var.project_id
  name              = "storage-function-example"
  description       = "Example Cloud Function triggered by storage events"
  runtime           = "nodejs14"
  region            = var.region
  source_directory  = "${path.module}/functions/hello-world"
  bucket_name       = google_storage_bucket.function_bucket.name
  function_path     = "index.js"
  function_name     = "helloWorld"
  entry_point       = "helloWorld"
  event_trigger     = {
    event_type     = "google.storage.object.finalize"
    resource       = module.cloud_storage.bucket.name
    failure_policy = false
  }

  environment_variables = {
    PROJECT_ID = var.project_id
  }

  depends_on = [
    google_storage_bucket_object.function_code
  ]
}
