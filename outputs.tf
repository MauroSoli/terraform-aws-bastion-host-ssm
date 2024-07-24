output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID of the security group assigned to the bastion host."
}

output "bastion_iam_role_arn" {
  value = length(module.instance_profile_role) > 0 ? module.instance_profile_role[0].iam_role_arn : null
}

output "bastion_iam_role_name" {
  value = length(module.instance_profile_role) > 0 ? module.instance_profile_role[0].iam_role_name : null
}
