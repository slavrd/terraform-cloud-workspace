terraform {
  required_version = "~> 0.12.26"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.14"
    }
  }
}