# Terraform Cloud/Enterprise create workspace

A project to create a simple workspace in Terraform Cloud / Enterprise. The project is basic and allows only variables to be set for the workspace. All other settings will be default.

## Usage

To use the project to create a workspace

- Set the terraform variables. Check `variables.tf` file for available variables and description of what they are used for.

**Note:** Terraform Cloud / Enterprise workspace variables are represented as a maps. The keys of the map are the variables which will be created. The values are objects representing each variable's properties - value, description and weather to be marked as sensitive.

Example of value of `env_vars` to set two environment variables in the TFC/E workspace:

```hcl
env_vars = {
  ENV_VAR_1 = {
    value       = "value1"
    sensitive   = true
    description = "Description of ENV_VAR_1"
  }
  ENV_VAR_2 = {
    value       = "value2"
    sensitive   = false
    description = "Description of ENV_VAR_2"
  }
}

tf_vars {
  string_tf_var = {
    value       = "value1"
    sensitive   = true
    description = "Description of string_tf_var"
    hcl         = false
  }
  hcl_list_tf_var = {
    value       = "[\"string1\", \"string2\"]"
    sensitive   = false
    description = "Description of hcl_list_tf_var"
    hcl         = true
  }
}
```

Setting workspace terraform variables using the `tf_vars` input variable is analogical.

- Initialize Terraform

```bash
terraform init
```

- Create workspace

```bash
terraform apply
```

- Delete workspace

```bash
terraform destroy
```
