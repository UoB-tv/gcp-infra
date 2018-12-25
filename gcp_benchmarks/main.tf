provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

resource "google_compute_instance" "iperf_server" {
    name = "network-perf-test-server"
    machine_type = "n1-standard-4"
    zone = "${var.zone}"

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

    metadata_startup_script = <<EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y iperf3
        iperf3 -s
    EOF
}

resource "google_compute_instance" "iperf_client_n1_std_1" {
    name = "network-perf-test-n1-std-1"
    machine_type = "n1-standard-1"
    zone="${var.zone}"

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

    metadata_startup_script = <<EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y iperf3
    EOF
}



resource "google_compute_instance" "iperf_client_n1_std_2" {
    name = "network-perf-test-n1-std-2"
    machine_type = "n1-standard-2"
    zone="${var.zone}"

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

    metadata_startup_script = <<EOF
        #!/bin/bash
        sudo apt-get update -y
        sudo apt-get install -y iperf3
    EOF
}

output "network_perf_server_ip"{
    value = "${google_compute_instance.iperf_server.network_interface.0.network_ip}"
}

output "network_perf_n1_std_1_ip" {
    value = "${google_compute_instance.iperf_client_n1_std_1.network_interface.0.network_ip}"
}

output "network_perf_n1_std_2_ip" {
    value = "${google_compute_instance.iperf_client_n1_std_2.network_interface.0.network_ip}"
}