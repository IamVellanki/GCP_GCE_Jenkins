provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file("C:\\GCPCICD\\GCP_GCE_Jenkins\\credentials.json")
}

module "compute_instance" {
  source        = "./modules/compute_instance"
  instance_name = var.instance_name
  machine_type  = var.machine_type
  zone          = var.zone
  image         = var.image
  region        = var.region
  project_id    = var.project_id

  # Pass existing network details to the Compute Engine module
  network    = "custom-vpc"
  subnetwork = "custom-subnet"
}