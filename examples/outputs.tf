output "file_system_id" {
  description = "The ID of the file system for which the mount target is intended"

  value = module.efs.file_system_id
}

output "file_system_dns_name" {
  description = "The DNS name for the EFS file system"

  value = module.efs.file_system_dns_name
}

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = module.efs.file_system_arn
}

output "efs_security_group_id" {
  description = "EFS security group Id"
  value       = module.security_group.security_group_id
}

output "efs_security_group_arn" {
  description = "EFS security group ARN"
  value       = module.security_group.security_group_arn
}

output "efs_security_group_vpc_id" {
  description = "EFS VPC Id"
  value       = module.security_group.security_group_vpc_id
}
