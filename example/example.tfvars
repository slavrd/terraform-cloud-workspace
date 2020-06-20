workspace_name    = "example-workspace"
workspace_org     = "my-tfe-organization"
terraform_version = "0.12.26"

env_vars = {
  SECURE_ENV_VAR = {
    value     = "very_secure_long_string"
    sensitive = true
  }
  CONFIRM_DESTROY = {
    value       = "1"
    description = ""
  }
  TF_LOG = {
    value       = "INFO"
    description = "Sets logging level"
  }
}

tf_vars = {
  regular_var = {
    value = "some_string"
  }
  map_var = {
    value = "{ key1   = \"val1\", key2 = \"val2\"}"
    hcl   = true
  }
  bool_var = {
    value       = "true"
    description = "will satisfy input variable from type bool"
    hcl         = true
  }
}
