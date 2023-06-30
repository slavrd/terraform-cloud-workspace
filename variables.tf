variable "workspace_name" {
  type        = string
  description = "The name of the TFC workspace to create."
}

variable "workspace_org" {
  type        = string
  description = "The name of the TFC organization in which to create."
}

variable "env_vars" {
  type = map(object({
    value       = string
    description = optional(string)
    sensitive   = optional(bool)
  }))
  description = "Environment variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive."
  default     = {}
}

variable "tf_vars" {
  type = map(object({
    value       = string
    description = optional(string)
    sensitive   = optional(bool)
    hcl         = optional(bool)
  }))
  description = "Terraform variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive, hcl."
  default     = {}
}

variable "terraform_version" {
  type        = string
  description = "The version of Terraform to use for this workspace. Defaults to the latest available version."
  default     = null
}

variable "execution_mode" {
  type        = string
  description = "Which execution mode to use. Using Terraform Cloud, valid values are remote, local or agent."
  default     = null

}

variable "working_directory" {
  type        = string
  description = "A relative path that Terraform will execute within."
  default     = null
}

variable "global_remote_state" {
  type        = bool
  description = "Whether the workspace allows all workspaces in the organization to access its state data during runs."
  default     = null
}

variable "remote_state_consumer_ids" {
  type        = list(string)
  description = "Whether the workspace allows all workspaces in the organization to access its state data during runs."
  default     = null
}

variable "queue_all_runs" {
  type        = bool
  description = "Whether the workspace should start automatically performing runs immediately after its creation."
  default     = null
}

variable "project_id" {
  type        = string
  description = "ID of the project where the workspace should be created."
  default     = null
}

variable "assessments_enabled" {
  type        = bool
  description = "Enable health assessments."
  default     = null
}

variable "vcs_repo" {
  type = object({
    identifier                 = string
    oauth_token_id             = optional(string)
    github_app_installation_id = optional(string)
    branch                     = optional(string)
    ingress_submodules         = optional(bool)
    tags_regex                 = optional(string)
  })
  description = "An object representing the vcs_repo settings as described in https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace#vcs_repo."
  validation {
    condition     = var.vcs_repo == null || try(alltrue([!alltrue([var.vcs_repo.oauth_token_id == null, var.vcs_repo.github_app_installation_id == null]), !alltrue([var.vcs_repo.oauth_token_id != null, var.vcs_repo.github_app_installation_id != null])]), false)
    error_message = "Variable validation: 'identifier' must be set and exactly one of 'oauth_token_id' or 'github_app_installation_id' must be set."
  }
  default = null
}
