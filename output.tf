output "workspace_name" {
  description = "The name of the created TFC workspace."
  value       = tfe_workspace.workspace.name
}

output "backend" {
  description = "Terraform remote backend configuratoin to use the created workspace."
  value       = data.template_file.backend.rendered
}