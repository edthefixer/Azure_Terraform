variable "location" {
  description = "Default Azure region used when a specific AVD location is not set."
  type        = string
  default     = "East US"
}

variable "location_short" {
  description = "Default short region code used in naming (example: eus, weu)."
  type        = string
  default     = "eus"
}

variable "management_plane_location_short" {
  description = "Short region code for management plane naming."
  type        = string
  default     = null
}

variable "session_host_location_short" {
  description = "Short region code for session host naming."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  description = "Azure subscription ID (optional, used by the provider)."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Azure tenant ID (optional, used by the provider)."
  type        = string
  default     = null
}
