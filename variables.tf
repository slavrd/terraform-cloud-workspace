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

variable "vcs_repo" {
  type        = map(any)
  description = "A mapping of vcs_repo settings as described in https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace#vcs_repo. If provided must contain `identifier` and `oauth_token_id` keys."
  validation {
    condition     = var.vcs_repo == tomap({}) || alltrue([contains(keys(var.vcs_repo), "identifier"), contains(keys(var.vcs_repo), "oauth_token_id")])
    error_message = "The `vcs_repo` variable value must contain `identifier` and `oauth_token_id` keys."
  }
  default = {}
}
