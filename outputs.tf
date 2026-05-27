output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "policy_arn" {
  description = "ARN of the attached policy"
  value       = try(aws_iam_role_policy_attachment.this[0].policy_arn, null)
}

output "role" {
  description = "Name of the role the policy is attached to"
  value       = try(aws_iam_role_policy_attachment.this[0].role, null)
}
