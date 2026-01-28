output "create_time" {
  description = "The timestamp when the resource was created."
  value       = google_network_services_authz_extension.this.create_time
}

output "id" {
  description = "The fully qualified identifier of the AuthzExtension resource."
  value       = google_network_services_authz_extension.this.id
}

output "name" {
  description = "The name of the created AuthzExtension resource."
  value       = google_network_services_authz_extension.this.name
}

output "update_time" {
  description = "The timestamp when the resource was last updated."
  value       = google_network_services_authz_extension.this.update_time
}
