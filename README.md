# Terraform Cloud/Enterprise create workspace

A module to create a simple Terraform Cloud / Enterprise workspace.

Currently the module only manages the name of the workspace, the terraform version and the variables.

## Usage

An example tf code that uses the module is placed in the `example/` directory. 

In addition to using the module the example code also demonstrates the use of a `template_file` data source to output the needed backend configuration for using the managed workspace.

## Input Variables

Below is a table of the available input variables

| Variable | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| workspace_name | `string` | | The name of the TFC workspace to create. |
| workspace_org | `string` | | The name of the TFC organization in which to create. |
| env_vars | `map(map(any))` | `{}` | Environment variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive. Example values are in the note below the table. |
| tf_vars | `map(map(any))` | `{}` | Terraform variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive, hcl. |
| terraform_version | `string` | `null` | The version of Terraform to use for this workspace. Defaults to the latest available version. |
| execution_mode | `string` | `null` | Which execution mode to use. Using Terraform Cloud, valid values are remote, local or agent. |
| working_directory | `string` | `null` | A relative path that Terraform will execute within. |
| vcs_repo | `map(string)` | `{}` | A mapping of vcs_repo settings as described in [tfe_workspace documentation](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace#vcs_repo). If provided must contain `identifier` and `oauth_token_id` keys. |

**Note:** Terraform Cloud / Enterprise workspace variables are represented as a maps. The keys of the map are the variables which will be created. The values are also maps which key/value pairs set the variable's properties - value, description, sensitive or hcl. Value is mandatory.

Example of setting the `env_vars` and `tf_vars` in a terraform variables file:

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

## Todo

- [x] change variable definitions and usage to use current type constraints
- [ ] add workspace features
    - [ ] add support to assign workspace to project
    - [ ] add support to enable workspace health assessments
    - [x] add support to enable worksapce output sharing
    - [ ] add support to disable auto run queueing on creation
