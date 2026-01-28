# It is a must-have requirement that the user is able to create an AuthzPolicyExtensions resource.
# This module creates a `google_network_services_authz_extension` resource which allows for flexible authorization policies in a service mesh
# using an external gRPC authorizer.
# <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
resource "google_network_services_authz_extension" "this" {
  # Required. The authority header of the gRPC request.
  authority = var.authority
  # A free-text description of the resource.
  description = var.description
  # A set of key/value label pairs to assign to the resource.
  labels = var.labels
  # The load balancing scheme for which the AuthzExtension is applicable.
  # Possible values are: `INTERNAL_MANAGED`, `EXTERNAL_MANAGED`.
  load_balancing_scheme = var.load_balancing_scheme
  # The location of the AuthzExtension resource.
  location = var.location
  # The name of the AuthzExtension resource.
  name = var.name
  # The ID of the project in which the resource belongs.
  project = var.project_id
  # The name of a BackendService that services the requests of the ext_authz gRPC authorization service.
  service = var.service
  # Required. The timeout for the authorization check.
  # A duration in seconds with up to nine fractional digits, ending with 's'. Example: "3.5s".
  timeout = var.timeout
}
