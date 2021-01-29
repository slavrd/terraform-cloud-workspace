resource "tfe_workspace" "workspace" {
  name              = var.workspace_name
  organization      = var.workspace_org
  terraform_version = var.terraform_version
  execution_mode    = var.execution_mode
  working_directory = var.working_directory

  dynamic "vcs_repo" {
    for_each = var.vcs_repo == tomap({}) ? [] : [var.vcs_repo]
    content {
      identifier         = vcs_repo.value["identifier"]
      oauth_token_id     = vcs_repo.value["oauth_token_id"]
      branch             = lookup(vcs_repo.value, "branch", null)
      ingress_submodules = lookup(vcs_repo.value, "ingress_submodules", null)
    }
  }
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
