provider "tfe" {
  version  = "~> 0.14"
  token    = var.tfe_token
  hostname = var.tfe_hostname
}

terraform {
  required_version = "~> 0.12.20"
}

resource "tfe_workspace" "workspace" {
  name         = var.workspace_name
  organization = var.workspace_org
}

resource "tfe_variable" "env_vars" {
  for_each     = var.env_vars
  key          = each.key
  value        = each.value["value"]
  sensitive    = try(each.value["sensitive"], null)
  description  = try(each.value["description"], null)
  category     = "env"
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tf_vars" {
  for_each     = var.tf_vars
  key          = each.key
  value        = each.value["value"]
  sensitive    = try(each.value["sensitive"], null)
  description  = try(each.value["description"], null)
  hcl          = try(each.value["hcl"], null)
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}

data "template_file" "backend" {
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
    ws_name      = tfe_workspace.workspace.name
    org_name     = tfe_workspace.workspace.organization
    tfe_hostname = var.tfe_hostname
  }
}
