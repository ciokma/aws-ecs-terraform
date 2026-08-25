variable "name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Number of days before the secret is permanently deleted"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags for the secret"
  type        = map(string)
  default     = {}
}