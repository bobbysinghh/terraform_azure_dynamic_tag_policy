provider "azurerm" {
  features {}
}
module "tag_policy" {
  source = "../"
  policy_name          = "appServiceMSI"
  policy_mode          = "All"
  policy_display_name  = "App Service"
  not_scopes           = null
  location             = null
  required_tags = {
    department = {
      tagName         = "department"
      tagPolicyEffect = "Disabled"
    },
  }
}