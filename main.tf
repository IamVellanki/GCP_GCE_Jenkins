provider "google" {
  project     = "gce03021991"
  region      = "us-central1"
  credentials = file("C:\\GCPCICD\\GCP_GCE\\credentials.json")
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-gce-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Assigns a public IP
    }
  }
}

output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
