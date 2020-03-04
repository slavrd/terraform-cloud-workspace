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
    description = string
    sensitive   = bool
  }))
  description = "Environment variables to set in the TFC workspace. The map key is the variable name while the map value is an object representing the variable properties."
  default     = {}
}

variable "tf_vars" {
  type = map(object({
    value       = string
    description = string
    sensitive   = bool
  }))
  description = "Terraform variables to set in the TFC workspace. The map key is the variable name while the map value is an object representing the variable properties."
  default     = {}
}

variable "tfe_token" {
  type        = string
  description = "Terraform Cloud / Enterprise user access token. Leave the default value to use the Terraform CLI credentials file insted."
  default     = null
}