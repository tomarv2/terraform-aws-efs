module "efs" {
  source = "../"

  email                  = "varun.tomar@databricks.com"
  account_id             = "755921336062"
  security_groups_to_use = [module.security_group.security_group_id]
  #-------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "security_group" {
  source = "git::git@github.com:tomarv2/terraform-aws-security-group.git?ref=v0.0.1"

  email         = "varun.tomar@databricks.com"
  service_ports = [5432]
  #-------------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
