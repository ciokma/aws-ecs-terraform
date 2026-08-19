variable "name" {
  description = "Base name for IAM resources."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}