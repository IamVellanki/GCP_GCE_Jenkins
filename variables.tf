variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "image" {
  description = "OS image for the VM"
  type        = string
}

variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}