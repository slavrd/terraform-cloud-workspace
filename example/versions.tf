terraform {
  required_providers {
    template = {
      source = "hashicorp/template"
    }
    tfe = {
      source = "hashicorp/tfe"
    }
  }
  required_version = ">= 0.12.26"
}
