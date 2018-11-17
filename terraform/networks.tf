resource "google_dns_managed_zone" "ubo-tv-internal-zone" {
    name = "uob-tv-internal-zone"
    dns_name = "internal.uob.tv."
}

resource "google_dns_managed_zone" "ubo-tv-public-zone" {
    name = "uob-tv-public-zone"
    dns_name = "uob.tv."
}