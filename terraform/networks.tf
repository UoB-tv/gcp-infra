resource "google_dns_managed_zone" "ubo-tv-public-zone" {
    name = "uob-tv-public-zone"
    dns_name = "uob-tv.co.uk."
}


resource "google_compute_global_address" "uob-tv-global-public-ip" {
    name = "uob-tv-global-public-ip"
}

resource "google_dns_record_set" "uob-tv-www-a-record" {
    name = "${google_dns_managed_zone.ubo-tv-public-zone.dns_name}"
    type = "A"
    ttl  = 300

    managed_zone = "${google_dns_managed_zone.ubo-tv-public-zone.name}"

    rrdatas = ["${google_compute_global_address.uob-tv-global-public-ip.address}"]
}

resource "google_dns_record_set" "uob-tv-www-cname-record" {
    name = "www.${google_dns_managed_zone.ubo-tv-public-zone.dns_name}"
    type = "CNAME"
    ttl  = 300

    managed_zone = "${google_dns_managed_zone.ubo-tv-public-zone.name}"
    rrdatas = ["${google_dns_managed_zone.ubo-tv-public-zone.dns_name}"]
}

output "uob-tv-global-public-ip" {
    value = "${google_compute_global_address.uob-tv-global-public-ip.address}"
}