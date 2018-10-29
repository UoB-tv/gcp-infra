resource "google_compute_instance" "jenkins_master" {
    name = "jenkins-master"
    machine-type = "g1-small-1"
    zone = "${var.zone}"

    tags = ["jenkins", "master", "ci"]

    boot_disk {
        auto_delete = false
        initialize_params {
            initialize_params = "ubuntu-1604-xenial-v20181023"
        }
    }

    network_interface {
        network = "default"

    }
    
    service_account {
        scopes = ["userinfo-email", "compute-rw", "storage-rw"]
    }
}