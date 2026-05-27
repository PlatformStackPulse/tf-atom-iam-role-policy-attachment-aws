# -----------------------------------------------------
# Atom: IAM Role Policy Attachment
# Attaches a single managed policy to an IAM role.
# -----------------------------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  count = module.this.enabled ? 1 : 0

  role       = var.role_name
  policy_arn = var.policy_arn
}
