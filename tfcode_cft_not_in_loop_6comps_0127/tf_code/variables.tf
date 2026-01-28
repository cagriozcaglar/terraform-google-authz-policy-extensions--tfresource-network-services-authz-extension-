# The action to take when a rule is matched. Possible values are "ALLOW" or "DENY".
variable "action" {
  description = "The action to take when a rule is matched. Possible values are \"ALLOW\" or \"DENY\"."
  type        = string
  default     = "ALLOW"
  validation {
    condition     = contains(["ALLOW", "DENY"], var.action)
    error_message = "The action must be either ALLOW or DENY."
  }
}

# A free-text description of the resource.
variable "description" {
  description = "A free-text description of the resource."
  type        = string
  default     = null
}

# Set of label tags associated with the authorization policy.
variable "labels" {
  description = "Set of label tags associated with the authorization policy."
  type        = map(string)
  default     = null
}

# The location of the authorization policy.
variable "location" {
  description = "The location of the authorization policy."
  type        = string
  default     = "global"
}

# The name of the authorization policy. If not provided, a random name will be generated.
variable "name" {
  description = "The name of the authorization policy. A unique name is required for each authorization policy in a project and location. If not provided, a random name will be generated."
  type        = string
  default     = null
}

# The ID of the project in which the resource belongs.
variable "project_id" {
  description = "The ID of the project in which the resource belongs. If not provided, the provider project is used."
  type        = string
  default     = null
}

# A list of rules that specify the matching criteria for the authorization policy.
variable "rules" {
  description = <<-EOD
  A list of rules that specify the matching criteria for the authorization policy. Each rule is an object with the following attributes:
  - `sources`: (Optional) A list of source objects. Each source object can have the following attributes:
    - `principals`: (Optional) A list of peer identities to match for the source.
    - `ip_blocks`: (Optional) A list of CIDR ranges to match for the source.
  - `destinations`: (Optional) A list of destination objects. Each destination object can have the following attributes:
    - `hosts`: (Required) A list of host names to match in HTTP 'Host' header.
    - `ports`: (Required) A list of port numbers to match on the destination.
    - `methods`: (Optional) A list of HTTP methods to match.
    - `http_header_match`: (Optional) An object specifying HTTP header match attributes:
      - `header_name`: (Required) The name of the HTTP header to match.
      - `regex_match`: (Required) The value of the header must match the regular expression.
  EOD
  type = list(object({
    sources = optional(list(object({
      principals = optional(list(string))
      ip_blocks  = optional(list(string))
    })))
    destinations = optional(list(object({
      hosts             = list(string)
      ports             = list(number)
      methods           = optional(list(string))
      http_header_match = optional(object({
        header_name = string
        regex_match = string
      }))
    })))
  }))
  default = []
}
