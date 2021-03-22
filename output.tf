output "file_system_id" {
  value = join("", aws_efs_file_system.efs.*.id)
}

output "dns_name" {
  value = join("", aws_efs_file_system.efs.*.dns_name)
}

//output "mount_target_ids" {
//  value = join(",", aws_efs_mount_target.efs.*.id)
//}
//
//output "mount_target_interface_ids" {
//  value = join(",", aws_efs_mount_target.efs.*.network_interface_id)
//}
