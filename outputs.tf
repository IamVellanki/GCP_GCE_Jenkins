output "instance_public_ip" {
  description = "Public IP of the VM instance"
  value       = module.compute_instance.instance_public_ip
}

output "instance_internal_ip" {
  description = "Internal IP of the VM instance"
  value       = module.compute_instance.instance_internal_ip
}