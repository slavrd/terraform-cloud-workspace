output "workspace_name" {
  description = "The name of the created TFC workspace."
  value       = module.tfc_workspace_example.workspace_name
}

output "backend_config" {
  description = "Terraform remote backend configuratoin to use the created workspace."
  value       = data.template_file.backend_config.rendered
}