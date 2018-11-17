resource "google_compute_instance" "vpn-server" {
    name = "${var.name}"
    machine-type = "${var.machine-type}"
    zone = "${var.zone}"

    tags = ["vpn", "internal"]

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

