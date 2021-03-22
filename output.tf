output "file_system_id" {
  value = join("", aws_efs_file_system.efs.*.id)
}

output "file_system_dns_name" {
  value = join("", aws_efs_file_system.efs.*.dns_name)
}

output "file_system_arn" {
  value = join("", aws_efs_file_system.efs.*.arn)
}