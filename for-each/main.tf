variable "instance_names" {
    description = "GCE Instance Identifiers"
    type        = set(string)
    default     = ["webserver", "appserver", "dbserver"]
}
# 3 Google Cloud Compute Engine Instances
resource "google_compute_instance" "default" {
  for_each = var.instance_names # For each loop with accompanying 'each' object
  name = each.value # Dynamic naming matched with value of 'each' set item
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