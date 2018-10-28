resource "google_container_node_pool" "pool_1" {
    name = "pool-1"
    zone="${var.zone}"
    cluster= "${google_container_cluster.dev_cluster_1.name}"

    autoscaling = {
        min_node_count = 1
        max_node_count = 5
    }
    initial_node_count = 1

    node_config {
        preemptible = false
        machine_type = "n1-standard-1"

        oauth_scopes = [
            "compute-rw",
            "storage-ro",
            "logging-write",
            "monitoring",
        ]
        disk_size_gb = 30
    }
}

resource "google_container_cluster" "dev_cluster_1" {
    name = "dev-cluster-1"
    zone = "${var.gke_zone}"
    node_version = "1.10.7-gke.6"
    min_master_version = "1.10.7-gke.6"

    addons_config {
        horizontal_pod_autoscaling {
            disabled = false
        }
    }
}

output "cluster_name" {
    value = "${google_container_cluster.dev_cluster_1.name}"
}

/*

output "client_certificate" {
  value = "${google_container_cluster.dev_cluster_1.master_auth.0.client_certificate}"
}

output "client_key" {
    value = "${google_container_cluster.dev_cluster_1.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.dev_cluster_1.master_auth.0.cluster_ca_certificate}"
}

*/