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

resource "google_compute_firewall" "www" {
  name = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8080", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}