variable "policy_name" {
  type    = string
  default = ""
}

variable "policy_type" {
  type    = string
  default = "Custom"
}

variable "policy_mode" {
  type    = string
  default = "All"
}

variable "policy_display_name" {
  type    = string
  default = ""
}

variable "policy_description" {
  type    = string
  default = "Required tag policy"
}
variable "subscription_id" {
  type    = string
  default = ""
}
variable "location" {
  type    = string
  default = null
}
variable "not_scopes" {
  type    = list(any)
  default = null
}
variable "metadata" {
  type = map(any)
  default = {
    "version" : "1.0.0",
    "category" : "App Service"
  }
}
variable "required_tags" {
  type = map(object({
    tagName         = string
    tagPolicyEffect = string
  }))
  default = {
    department = {
      tagName         = "department"
      tagPolicyEffect = "Disabled"
    },

  }
}

