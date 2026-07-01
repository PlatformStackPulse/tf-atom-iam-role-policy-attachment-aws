# Unit Tests for tf-atom-iam-role-policy-attachment-aws
#
# These tests use a mock provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
#
# Assertions target plan-KNOWN values only (tf-label id, enabled output,
# input pass-throughs, resource count). Computed values such as the real
# policy_arn/role attributes are unknown under a mock provider and are NOT
# asserted on.

mock_provider "aws" {}

variables {
  # tf-label identity inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-required inputs
  role_name  = "eg-test-role"
  policy_arn = "arn:aws:iam::123456789012:policy/eg-test-policy"
}

# ---------------------------------------------------------------------------
# Test: module creates the attachment when enabled (default)
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = length(aws_iam_role_policy_attachment.this) == 1
    error_message = "exactly one policy attachment should be planned when enabled"
  }

  assert {
    condition     = aws_iam_role_policy_attachment.this[0].role == "eg-test-role"
    error_message = "attachment role should pass through the role_name input"
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_iam_role_policy_attachment.this) == 0
    error_message = "no policy attachment should be planned when disabled"
  }

  assert {
    condition     = output.policy_arn == null
    error_message = "policy_arn output should be null when the module is disabled"
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when the module is disabled"
  }
}
