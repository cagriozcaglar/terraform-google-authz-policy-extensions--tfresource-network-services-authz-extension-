# Google Network Security Authorization Policy Module

This module simplifies the creation and management of a Google Cloud Network Security Authorization Policy.

Authorization Policies are used to authorize inbound connections. After a policy is created, it can be attached to a target endpoint (such as a target HTTPS proxy) to enforce the policy.

This module configures a single `google_network_security_authorization_policy` resource, including its rules for matching sources and destinations.

## Compatibility
This module is meant for use with version 5.0+ of the Google Cloud Beta provider.

## Usage

Basic usage of this module is as follows:

```hcl
module "auth_policy" {
  source      = "path/to/module"
  project_id  = "your-gcp-project-id"
  name        = "my-web-allow-policy"
  location    = "global"
  action      = "ALLOW"
  description = "Allow traffic from internal VPC and specific principals to web servers."
  labels = {
    env = "production"
  }

  rules = [
    {
      sources = [
        {
          ip_blocks  = ["10.0.0.0/8"]
          principals = ["projects/123456789/serviceAccounts/my-service-account@my-project.iam.gserviceaccount.com"]
        }
      ]
      destinations = [
        {
          hosts = ["*.example.com"]
          ports = [443]
          methods = ["GET", "POST"]
          http_header_match = {
            header_name = "X-Custom-Header"
            regex_match = "prod-.*"
          }
        }
      ]
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | The action to take when a rule is matched. Possible values are "ALLOW" or "DENY". | `string` | `"ALLOW"` | no |
| <a name="input_description"></a> [description](#input\_description) | A free-text description of the resource. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Set of label tags associated with the authorization policy. | `map(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the authorization policy. | `string` | `"global"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the authorization policy. A unique name is required for each authorization policy in a project and location. If not provided, a random name will be generated. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs. If not provided, the provider project is used. | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | A list of rules that specify the matching criteria for the authorization policy. Each rule is an object with the following attributes:<br>- `sources`: (Optional) A list of source objects. Each source object can have the following attributes:<br>  - `principals`: (Optional) A list of peer identities to match for the source.<br>  - `ip_blocks`: (Optional) A list of CIDR ranges to match for the source.<br>- `destinations`: (Optional) A list of destination objects. Each destination object can have the following attributes:<br>  - `hosts`: (Required) A list of host names to match in HTTP 'Host' header.<br>  - `ports`: (Required) A list of port numbers to match on the destination.<br>  - `methods`: (Optional) A list of HTTP methods to match.<br>  - `http_header_match`: (Optional) An object specifying HTTP header match attributes:<br>    - `header_name`: (Required) The name of the HTTP header to match.<br>    - `regex_match`: (Required) The value of the header must match the regular expression. | <pre>list(object({<br>    sources = optional(list(object({<br>      principals = optional(list(string))<br>      ip_blocks  = optional(list(string))<br>    })))<br>    destinations = optional(list(object({<br>      hosts             = list(string)<br>      ports             = list(number)<br>      methods           = optional(list(string))<br>      http_header_match = optional(object({<br>        header_name = string<br>        regex_match = string<br>      }))<br>    })))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_time"></a> [create\_time](#output\_create\_time) | The time when the authorization policy was created. |
| <a name="output_id"></a> [id](#output\_id) | The fully qualified ID of the authorization policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the authorization policy. |

## Requirements

### Terraform

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

### Providers

| Name | Version |
|------|---------|
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [google_network_security_authorization_policy.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/network_security_authorization_policy) | resource |
| [random_string.name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
