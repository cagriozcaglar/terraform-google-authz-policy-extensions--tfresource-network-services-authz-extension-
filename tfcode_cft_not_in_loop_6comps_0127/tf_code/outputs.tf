# The time when the authorization policy was created.
output "create_time" {
  description = "The time when the authorization policy was created."
  value       = google_network_security_authorization_policy.main.create_time
}

# The fully qualified ID of the authorization policy.
output "id" {
  description = "The fully qualified ID of the authorization policy."
  value       = google_network_security_authorization_policy.main.id
}

# The name of the authorization policy.
output "name" {
  description = "The name of the authorization policy."
  value       = google_network_security_authorization_policy.main.name
}
