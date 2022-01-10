resource "azurerm_policy_definition" "app_service_msi_definition" {
  name         = var.policy_name
  policy_type  = var.policy_type
  mode         = var.policy_mode
  display_name = var.policy_display_name
  description  = coalesce(var.policy_display_name, var.policy_description)
  metadata     = jsonencode(var.metadata)

  policy_rule = <<POLICY_RULE
   {
 "if": {
        "allOf": [
          {
            "field": "[concat('tags[', parameters('tagName'), ']')]",
            "exists": "false"
          }
        ]
      },
      "then": {
        "effect": "[parameters('tagPolicyEffect')]"
      }
    }
 POLICY_RULE


  parameters = <<PARAMETERS
   {
        "tagName": {
        "type": "String",
        "metadata": {
          "displayName": "Tag Required",
          "description": "Name of the tag, such as 'owner'"
        }
      },
      "tagPolicyEffect": {
             "type": "String",
                 "metadata": {
                 "displayName": "Effect",
                 "description": "Enable or disable the execution of the policy"
                 },
                 "allowedValues": [
                 "AuditIfNotExists",
                 "Disabled",
                 "Deny"
                 ],
                 "defaultValue": "AuditIfNotExists"
      }
  }
 PARAMETERS
}
resource "azurerm_subscription_policy_assignment" "example" {
  for_each             = var.required_tags
  name                 = "Assign Required Tags ${each.value.tagName}"
  subscription_id      = var.subscription_id == "" ? data.azurerm_subscription.current.id : var.subscription_id
  policy_definition_id = azurerm_policy_definition.app_service_msi_definition.id
  location             = var.location
  not_scopes           = var.not_scopes
  description          = "Policy Assignment created for Required Tag ${each.value.tagName}"
  display_name         = "Required Tag ${each.value.tagName}"


  parameters = <<PARAMETERS
    {
      "tagName": {"value": "${each.value.tagName}" },
      "tagPolicyEffect": {"value": "${each.value.tagPolicyEffect}" }
    }
PARAMETERS

}

