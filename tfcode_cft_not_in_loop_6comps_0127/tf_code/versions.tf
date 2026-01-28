terraform {
  required_version = ">= 1.3"
  required_providers {
    # The google-beta provider is used to configure Google Cloud resources.
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}
