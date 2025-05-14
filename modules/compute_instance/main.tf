data "google_compute_network" "existing_network" {
  name    = var.network  # Use variable passed from root-level main.tf
  project = var.project_id
}

data "google_compute_subnetwork" "existing_subnet" {
  name    = var.subnetwork  # Use variable passed from root-level main.tf
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = data.google_compute_network.existing_network.self_link
    subnetwork = data.google_compute_subnetwork.existing_subnet.self_link
    access_config {}  # Assign public IP
  }

  # Reference the startup script correctly
  metadata_startup_script = file("${path.module}/startup.sh")
}