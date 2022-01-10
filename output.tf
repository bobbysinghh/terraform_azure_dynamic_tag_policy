output "policy_id" {
  value = azurerm_policy_definition.app_service_msi_definition.id
}

output "policy_assignment_id" {
  value = azurerm_subscription_policy_assignment.example
}

output "Subscription_id" {
  value = var.subscription_id == "" ? data.azurerm_subscription.current.id : var.subscription_id

}
output "applied_tags" {
  value = var.required_tags
}