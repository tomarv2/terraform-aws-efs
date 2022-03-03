output "file_system_id" {
  description = "The ID of the file system for which the mount target is intended"
  value       = join("", aws_efs_file_system.efs.*.id)
}

output "file_system_dns_name" {
  description = "The DNS name for the EFS file system"
  value       = join("", aws_efs_file_system.efs.*.dns_name)
}

output "file_system_arn" {
  description = "Amazon Resource Name of the file system"
  value       = join("", aws_efs_file_system.efs.*.arn)
}
