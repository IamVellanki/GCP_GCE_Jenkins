output "instance_public_ip" {
  description = "The external IP assigned to the VM"
  value       = length(google_compute_instance.vm_instance.network_interface[0].access_config) > 0 ? google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip : "No external IP"
}

output "instance_internal_ip" {
  description = "Internal IP of the VM instance"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}