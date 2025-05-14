variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "image" {
  description = "OS image for the VM"
  type        = string
}
variable "network" {
  description = "VPC Network to attach the instance"
  type        = string
}

variable "subnetwork" {
  description = "Subnet to attach the instance"
  type        = string
}

variable "region" {
  description = "Region where the Compute Engine instance is deployed"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}
