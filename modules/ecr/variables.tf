variable "repository_name" {
  description = "ECR repository name."
  type        = string
}

variable "image_tag_mutability" {
  description = "ECR image tag mutability."
  type        = string

  default = "MUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable image scanning on push."
  type        = bool
  default     = true
}

variable "max_image_count" {
  description = "Maximum number of images to retain."
  type        = number
  default     = 20
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}