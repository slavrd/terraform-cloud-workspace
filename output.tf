output "workspace_name" {
  description = "The name of the created TFC workspace."
  value       = tfe_workspace.workspace.name
}