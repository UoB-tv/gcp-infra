
resource "google_storage_bucket" "uob-tv-infra-store" {
    name = "uob-tv-infra"
    location = "europe-west2"
    storage_class = "REGIONAL"
    versioning {
        enabled = false
    }
}

