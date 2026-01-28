variable "authority" {
  description = "Required. The authority header of the gRPC request."
  type        = string
  default     = "authz-ext.example.com"
}

variable "description" {
  description = "A free-text description of the resource."
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "load_balancing_scheme" {
  description = "The load balancing scheme for which the AuthzExtension is applicable. Must be one of `INTERNAL_MANAGED` or `EXTERNAL_MANAGED`."
  type        = string
  default     = "INTERNAL_MANAGED"

  validation {
    condition     = contains(["INTERNAL_MANAGED", "EXTERNAL_MANAGED"], var.load_balancing_scheme)
    error_message = "The load_balancing_scheme must be either INTERNAL_MANAGED or EXTERNAL_MANAGED."
  }
}

variable "location" {
  description = "The location of the AuthzExtension resource."
  type        = string
  default     = "global"
}

variable "name" {
  description = "The name of the AuthzExtension resource."
  type        = string
  default     = "my-authz-extension"
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If not provided, the provider project is used."
  type        = string
  default     = null
}

variable "service" {
  description = "The name of a BackendService that services the requests of the ext_authz gRPC authorization service. The format is `projects/{project}/global/backendServices/{backendService}`."
  type        = string
  # Note: This default value is a placeholder to allow the module to pass `terraform plan` without inputs in test environments.
  # It should be overridden with a valid Backend Service self-link in actual deployments.
  default = "projects/project-id/global/backendServices/backend-service-name"
}

variable "timeout" {
  description = "Required. The timeout for the authorization check. A duration in seconds with up to nine fractional digits, ending with 's'. Example: \"3.5s\"."
  type        = string
  default     = "10s"
}
