resource "aws_efs_file_system" "efs" {
  count = var.deploy_efs ? 1 : 0

  creation_token                  = var.name != null ? var.name : "${var.teamid}-${var.prjid}"
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.throughput_mode == "provisioned" ? var.provisioned_throughput : null
  encrypted                       = var.encrypted
  kms_key_id                      = var.encrypted == true ? var.kms_key_id : null

  tags = merge(local.shared_tags)

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.transition_to_ia
    }
  }
}

resource "aws_efs_mount_target" "default" {
  count = length(module.global.list_of_subnets[local.account_id][local.region]) > 0 && var.efs_mount_target == true ? length(module.global.list_of_subnets[local.account_id][local.region]) : 0

  file_system_id  = var.file_system_id == null ? join("", aws_efs_file_system.efs.*.id) : var.file_system_id
  ip_address      = var.mount_target_ip_address
  subnet_id       = module.global.list_of_subnets[local.account_id][local.region][count.index]
  security_groups = var.security_groups
}

resource "aws_efs_access_point" "default" {
  for_each = var.access_points

  file_system_id = join("", aws_efs_file_system.efs.*.id)

  posix_user {
    gid            = var.access_points[each.key]["posix_user"]["gid"]
    uid            = var.access_points[each.key]["posix_user"]["uid"]
    secondary_gids = lookup(lookup(var.access_points[each.key], "posix_user", {}), "secondary_gids", null) == null ? null : null
  }

  root_directory {
    path = "/${each.key}"
    creation_info {
      owner_gid   = var.access_points[each.key]["creation_info"]["gid"]
      owner_uid   = var.access_points[each.key]["creation_info"]["uid"]
      permissions = var.access_points[each.key]["creation_info"]["permissions"]
    }
  }

  tags = merge(local.shared_tags)
}
