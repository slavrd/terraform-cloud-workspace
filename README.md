# Terraform Cloud/Enterprise create workspace

A project to create a simple workspace in Terraform Cloud / Enterprise. The project is basic and allows only variables to be set for the workspace. All other settings will be default.

## Usage

To use the project to create a workspace

- Set the terraform variables. Check `variables.tf` file for available variables and description of what they are used for.

**Note:** Terraform Cloud / Enterprise workspace variables are represented as a maps. The keys of the map are the variables which will be created. The values are also maps which key/value pairs set the variable's properties - value, description, sensitive or hcl.

Example of a `.tfvars` file:

```hcl
env_vars = {
  ENV_VAR_1 = {
    value       = "value1"
  }
  ENV_VAR_2 = {
    value       = "value2"
    sensitive   = true
    description = "Description of ENV_VAR_2"
  }
}

tf_vars = {
  string_tf_var = {
    value       = "value1"
    sensitive   = true
  }
  hcl_list_tf_var = {
    value       = "[\"string1\", \"string2\"]"
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
