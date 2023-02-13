terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}
provider "google" {
  credentials = "${file("../.sa_key")}"
  project = "cal-842-46d9ef40480b"
  region = "us-central1"
}
variable "instance_names" {
    description = "GCE Instance Identifiers"
    type        = list(string)
    default     = ["webserver", "appserver", "dbserver"]
}
# 3 Google Cloud Compute Engine Instances
resource "google_compute_instance" "default" {
  count = length(var.instance_names) # Number of resources to deploy
  name = var.instance_names[count.index] # Dynamic naming matched with list index
  machine_type = "f1-micro"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
}
output "instance_ids" {
    value = {
        for key, value in google_compute_instance.default : key => value.instance_id
    }
}