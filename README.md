# Terraform Cloud/Enterprise create workspace

A project to create a simple workspace in Terraform Cloud / Enterprise. The project is basic and allows only variables to be set for the workspace. All other settings will be default.

## Usage

To use the project to create a workspace

- Set the terraform variables. Check `variables.tf` file for available variables and description of what they are used for.

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
