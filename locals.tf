locals {
  shared_tags = map(
    "Name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
