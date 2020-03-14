variable "workspace_name" {
  type        = string
  description = "The name of the TFC workspace to create."
}

variable "workspace_org" {
  type        = string
  description = "The name of the TFC organization in which to create."
}

variable "env_vars" {
  type = map(map(any))
  description = "Environment variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive."
  default     = {}
}

variable "tf_vars" {
  type = map(map(any))
  description = "Terraform variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive, hcl."
  default     = {}
}

variable "tfe_token" {
  type        = string
  description = "Terraform Cloud / Enterprise user access token. Leave the default value to use the Terraform CLI credentials file insted."
  default     = null
}