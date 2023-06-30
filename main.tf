resource "tfe_workspace" "workspace" {
  name                      = var.workspace_name
  organization              = var.workspace_org
  terraform_version         = var.terraform_version
  execution_mode            = var.execution_mode
  working_directory         = var.working_directory
  global_remote_state       = var.global_remote_state
  remote_state_consumer_ids = var.remote_state_consumer_ids
  queue_all_runs            = var.queue_all_runs
  project_id = var.project_id

  dynamic "vcs_repo" {
    for_each = var.vcs_repo == null ? [] : [var.vcs_repo]
    content {
      identifier                 = vcs_repo.value.identifier
      oauth_token_id             = vcs_repo.value.oauth_token_id
      github_app_installation_id = vcs_repo.value.github_app_installation_id
      branch                     = vcs_repo.value.branch
      ingress_submodules         = vcs_repo.value.ingress_submodules
      tags_regex                 = vcs_repo.value.tags_regex
    }
  }
}

resource "tfe_variable" "env_vars" {
  for_each     = var.env_vars
  key          = each.key
  value        = each.value.value
  sensitive    = each.value.sensitive
  description  = each.value.description
  category     = "env"
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "tf_vars" {
  for_each     = var.tf_vars
  key          = each.key
  value        = each.value.value
  sensitive    = each.value.sensitive
  description  = each.value.description
  hcl          = each.value.hcl
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}
