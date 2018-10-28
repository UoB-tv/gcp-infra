provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

resource "google_project_services" "project" {
  project = "${var.project_id}"
  services = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "datastore.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "sql-component.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudtrace.googleapis.com",
    "clouddebugger.googleapis.com",
    "logging.googleapis.com",
    "oslogin.googleapis.com",
    "cloudkms.googleapis.com",
    "bigquery-json.googleapis.com",
    "pubsub.googleapis.com",
    "storage-component.googleapis.com",
    "storage-api.googleapis.com",
    "cloudapis.googleapis.com",
    "clouderrorreporting.googleapis.com",
    "servicemanagement.googleapis.com"
  ]
}