# Google Cloud Network Services AuthzExtension

This module creates a `google_network_services_authz_extension` resource, which allows for flexible authorization policies in a service mesh by integrating with an external gRPC authorizer. It is used to configure how traffic is authorized before it reaches a backend service.

## Usage

Here is a basic example of how to use this module:

```hcl
module "authz_extension" {
  source                  = "./" # Or a path to this module
  project_id              = "your-gcp-project-id"
  name                    = "my-custom-authz-extension"
  location                = "global"
  service                 = "projects/your-gcp-project-id/global/backendServices/my-ext-authz-backend-service"
  authority               = "auth.example.com"
  timeout                 = "5s"
  load_balancing_scheme   = "INTERNAL_MANAGED"
  description             = "Authorization extension for my service mesh."
  labels = {
    env = "production"
  }
}
```

## Requirements

The following requirements are needed by this module.

### Software

The following software is required:
- [Terraform](https://www.terraform.io/downloads.html) >= 1.3
- [Terraform Provider for GCP](https://github.com/hashicorp/terraform-provider-google) ~> 5.25

### APIs

The following APIs must be enabled on the project:
- [Network Services API](https://console.cloud.google.com/apis/library/networkservices.googleapis.com): `networkservices.googleapis.com`

### Permissions

The service account or user account executing Terraform must have the following permissions on the project:
- `networkservices.authzExtensions.create`
- `networkservices.authzExtensions.get`
- `networkservices.authzExtensions.update`
- `networkservices.authzExtensions.delete`

The predefined `roles/networkservices.admin` role contains the necessary permissions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.25 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authority"></a> [authority](#input\_authority) | Required. The authority header of the gRPC request. | `string` | `"authz-ext.example.com"` | yes |
| <a name="input_description"></a> [description](#input\_description) | A free-text description of the resource. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_load_balancing_scheme"></a> [load\_balancing\_scheme](#input\_load\_balancing\_scheme) | The load balancing scheme for which the AuthzExtension is applicable. Must be one of `INTERNAL_MANAGED` or `EXTERNAL_MANAGED`. | `string` | `"INTERNAL_MANAGED"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the AuthzExtension resource. | `string` | `"global"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the AuthzExtension resource. | `string` | `"my-authz-extension"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs. If not provided, the provider project is used. | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | The name of a BackendService that services the requests of the ext\_authz gRPC authorization service. The format is `projects/{project}/global/backendServices/{backendService}`. | `string` | `"projects/project-id/global/backendServices/backend-service-name"` | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Required. The timeout for the authorization check. A duration in seconds with up to nine fractional digits, ending with 's'. Example: "3.5s". | `string` | `"10s"` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_time"></a> [create\_time](#output\_create\_time) | The timestamp when the resource was created. |
| <a name="output_id"></a> [id](#output\_id) | The fully qualified identifier of the AuthzExtension resource. |
| <a name="output_name"></a> [name](#output\_name) | The name of the created AuthzExtension resource. |
| <a name="output_update_time"></a> [update\_time](#output\_update\_time) | The timestamp when the resource was last updated. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
