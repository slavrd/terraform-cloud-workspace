# Terraform Cloud/Enterprise create workspace

A module to create a simple Terraform Cloud / Enterprise workspace.

Currently the module only manages the name of the workspace, the terraform version and the variables.

## Usage

An example tf code that uses the module is placed in the `example/` directory.

In addition to using the module the example code also demonstrates the use of a `template_file` data source to output the needed backend configuration for using the managed workspace.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Environment variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive. | <pre>map(object({<br>    value       = string<br>    description = optional(string)<br>    sensitive   = optional(bool)<br>  }))</pre> | `{}` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Which execution mode to use. Using Terraform Cloud, valid values are remote, local or agent. | `string` | `null` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Whether the workspace allows all workspaces in the organization to access its state data during runs. | `bool` | `null` | no |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | Whether the workspace should start automatically performing runs immediately after its creation. | `bool` | `null` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | Whether the workspace allows all workspaces in the organization to access its state data during runs. | `list(string)` | `null` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to use for this workspace. Defaults to the latest available version. | `string` | `null` | no |
| <a name="input_tf_vars"></a> [tf\_vars](#input\_tf\_vars) | Terraform variables to set in the TFC workspace. The map key is the workspace variable name. The value is another map where the key value pairs set the properties of the variable - value, description, sensitive, hcl. | <pre>map(object({<br>    value       = string<br>    description = optional(string)<br>    sensitive   = optional(bool)<br>    hcl         = optional(bool)<br>  }))</pre> | `{}` | no |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | An object representing the vcs\_repo settings as described in https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace#vcs_repo. | <pre>object({<br>    identifier                 = string<br>    oauth_token_id             = optional(string)<br>    github_app_installation_id = optional(string)<br>    branch                     = optional(string)<br>    ingress_submodules         = optional(bool)<br>    tags_regex                 = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within. | `string` | `null` | no |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | The name of the TFC workspace to create. | `string` | n/a | yes |
| <a name="input_workspace_org"></a> [workspace\_org](#input\_workspace\_org) | The name of the TFC organization in which to create. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The name of the created TFC workspace. |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.45 |

## Resources

| Name | Type |
|------|------|
| [tfe_variable.env_vars](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tf_vars](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Documentation

Generated with [terraform-docs](https://terraform-docs.io/user-guide/introduction/) . Configuration file is in `.terraform-docs.yml`.

To generate the docs

* Have [terraform-docs](https://terraform-docs.io/user-guide/introduction/) installed.
* Run
```bash
terraform-docs markdown table . > README.md
```

## Todo

- [x] change variable definitions and usage to use current type constraints
- [ ] add support to assign workspace to project
- [ ] add support to enable workspace health assessments
- [x] add support to enable workspace output sharing
- [x] add support to disable auto run queueing on creation
