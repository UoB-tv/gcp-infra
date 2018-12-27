provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

resource "google_compute_instance" "rtmp_server" {
    name = "rtmp-server"
    machine_type = "n1-standard-1"
    tags = ["test", "ephemeral"]

    boot_disk {
        initialize_params {
           image = "ubuntu-1804-lts"
        }
    }

    network_interface {
        network = "default"

        access_config {
        // Ephemeral IP
        }
    }
}


resource "google_compute_instance" "hls_stream_server" {
    name = "hls-stream-server"
    machine_type = "n1-standard-1"
    tags = ["test", "ephemeral"]

    boot_disk {
        initialize_params {
           image = "ubuntu-1804-lts"
        }
    }

    network_interface {
        network = "default"

        access_config {
        // Ephemeral IP
        }
    }
}