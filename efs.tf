resource "aws_efs_file_system" "efs" {
  count = var.deploy_efs ? 1 : 0

  creation_token   = "${var.teamid}-${var.prjid}"
  performance_mode = var.performance_mode
  encrypted        = var.encrypted
  tags             = merge(local.shared_tags)

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.transition_to_ia
    }
  }
}

resource "aws_efs_mount_target" "default" {
  count           = length(module.global.list_of_subnets[var.account_id][var.aws_region]) > 0 ? length(module.global.list_of_subnets[var.account_id][var.aws_region]) : 0
  file_system_id  = join("", aws_efs_file_system.efs.*.id)
  ip_address      = var.mount_target_ip_address
  subnet_id       = module.global.list_of_subnets[var.account_id][var.aws_region][count.index]
  security_groups = var.security_groups_to_use
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