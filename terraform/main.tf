provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

provider "kubernetes" {
  config_context_cluster = "gke_uob-tv-project-dev_europe-west2-a_dev-cluster-1"
  config_context_auth_info = "gke_uob-tv-project-dev_europe-west2-a_dev-cluster-1"
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
    "servicemanagement.googleapis.com",
    "cloudfunctions.googleapis.com",
    "dns.googleapis.com",
    "iap.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "bigtable.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}