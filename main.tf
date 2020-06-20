
terraform {
  required_version = "~> 0.12.20"
  required_providers {
    tfe = "~>0.14"
  }
}

resource "tfe_workspace" "workspace" {
  name              = var.workspace_name
  organization      = var.workspace_org
  terraform_version = var.terraform_version
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
