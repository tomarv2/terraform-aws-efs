output "file_system_id" {
  value = module.efs.file_system_id
}

output "file_system_dns_name" {
  value = module.efs.file_system_dns_name
}

output "file_system_arn" {
  value = module.efs.file_system_arn
}

output "efs_security_group_id" {
  value = module.security_group.security_group_id
}

output "efs_security_group_arn" {
  value = module.security_group.security_group_arn
}

output "efs_security_group_vpc_id" {
  value = module.security_group.security_group_vpc_id
}