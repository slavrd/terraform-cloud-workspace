provider "tfe" {
  token    = var.tfe_token
  hostname = var.tfe_hostname
}

module "tfc_workspace_example" {
  source = "github.com/slavrd/terraform-cloud-workspace"

  workspace_name    = var.workspace_name
  workspace_org     = var.workspace_org
  terraform_version = var.terraform_version
  env_vars          = var.env_vars
  tf_vars           = var.tf_vars
}

data "template_file" "backend_config" {
  template = <<-EOT
  terraform {
    backend "remote" {
      hostname     = "$${tfe_hostname}"
      organization = "$${org_name}"
      workspaces {
        name = "$${ws_name}"
      }
    }
  }
EOT
  vars = {
    ws_name      = module.tfc_workspace_example.workspace_name
    org_name     = var.workspace_org
    tfe_hostname = var.tfe_hostname
  }
}
