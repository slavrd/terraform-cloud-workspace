provider "tfe" {
  version = "~>0.14"
  token   = var.tfe_token
}

resource "tfe_workspace" "workspace" {
  name         = var.workspace_name
  organization = var.workspace_org
}

resource "tfe_variable" "env_vars" {
  for_each     = var.env_vars
  key          = each.key
  value        = each.value
  category     = "env"
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tf_vars" {
  for_each     = var.tf_vars
  key          = each.key
  value        = each.value
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}

data "template_file" "backend" {
  template = <<-EOT
  terraform {
    backend "remote" {
      organization = "$${org_name}"
      workspaces {
        name = "$${ws_name}"
      }
    }
  }
EOT
  vars = {
    ws_name  = tfe_workspace.workspace.name
    org_name = tfe_workspace.workspace.organization
  }
}