resource "google_compute_instance" "jenkins-master-1" {
    name = "${var.name}"
    machine-type = "${var.machine-type}"
    zone = "${var.zone}"

    tags = ["jenkins", "master", "ci"]

    boot_disk {
        auto_delete = false
        initialize_params {
            initialize_params = "${var.machine-image}"
        }
    }

    network_interface {
        network = "default"
        access_config {}
    }

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }

    metadata_startup_script = <<SCRIPT

    SCRIPT

    metadata {
        sshKeys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}

resource 

resource "google_compute_firewall" "www" {
    name = "tf-www-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["8080", "443"]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "google_dns_record_set" "jenkins-master" {
    name = "jenkins.${var.dns-domain}"
    managed_zone = "${var.dns-zone}"
    type = "A"
    ttl = "300"
    rrdatas = ["${google_compute_instance.jenkins-master-1.network_interface.0.access_config.0.nat_ip}"]
}
