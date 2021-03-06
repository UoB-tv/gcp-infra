variable "name" {
    description = "Name to be used for Jenkins master"
    default = "jenkins-master-1"
}

variable "machine-type" {
    default = "f1-micro"
}

variable "machine-image" {
    default = "ubuntu-1604-xenial-v20181023"
}

variable "zone" {
    default = "europe-west2-a"
}

variable "dns-domain" {
    default = "jenkins.internal.uob.tv"
}

variable "dns-zone" {
    default = "uob-tv-dns-zone"
}
