variable "role_name" {
  description = "Name of the IAM role to attach the policy to"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9+=,.@_-]+$", var.role_name))
    error_message = "role_name must contain only valid IAM role name characters."
  }
}

variable "policy_arn" {
  description = "ARN of the IAM policy to attach"
  type        = string

  validation {
    condition     = can(regex("^arn:aws:iam::", var.policy_arn))
    error_message = "policy_arn must be a valid IAM policy ARN."
  }
}
