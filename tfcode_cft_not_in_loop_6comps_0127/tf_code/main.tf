# Authorization Policy for Network Security.
# This resource defines a policy that can be used to authorize connections.
resource "google_network_security_authorization_policy" "main" {
  # The beta provider is used to create this resource.
  provider = google-beta

  # The name of the authorization policy. A unique name is required for each authorization policy in a project and location.
  name = var.name == null ? "auth-policy-${random_string.name_suffix.result}" : var.name

  # The location of the authorization policy.
  location = var.location

  # The ID of the project in which the resource belongs.
  project = var.project_id

  # The action to take when a rule is matched. Possible values are "ALLOW" or "DENY".
  action = var.action

  # A free-text description of the resource.
  description = var.description

  # Set of label tags associated with the authorization policy.
  labels = var.labels

  # A list of rules that specify the matching criteria for the authorization policy.
  dynamic "rules" {
    for_each = var.rules
    content {

      # A list of sources from which traffic is allowed or denied.
      dynamic "sources" {
        for_each = rules.value.sources == null ? [] : rules.value.sources
        content {
          # A list of peer identities to match for the source.
          principals = sources.value.principals
          # A list of CIDR ranges to match for the source.
          ip_blocks = sources.value.ip_blocks
        }
      }

      # A list of destinations for which traffic is allowed or denied.
      dynamic "destinations" {
        for_each = rules.value.destinations == null ? [] : rules.value.destinations
        content {
          # A list of host names to match in HTTP 'Host' header.
          hosts = destinations.value.hosts
          # A list of port numbers to match on the destination.
          ports = destinations.value.ports
          # A list of HTTP methods to match.
          methods = destinations.value.methods

          # A specification of HTTP header match attributes.
          dynamic "http_header_match" {
            for_each = destinations.value.http_header_match == null ? [] : [destinations.value.http_header_match]
            content {
              # The name of the HTTP header to match.
              header_name = http_header_match.value.header_name
              # The value of the header must match the regular expression.
              regex_match = http_header_match.value.regex_match
            }
          }
        }
      }
    }
  }
}

# Provides a random string for the authorization policy name.
resource "random_string" "name_suffix" {
  # The length of the random string.
  length = 8
  # Specifies that special characters should not be used in the random string.
  special = false
  # Specifies that uppercase letters should not be used in the random string.
  upper = false
}
