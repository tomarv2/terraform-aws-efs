locals {
  shared_tags = map(
    "Name", "${var.teamid}-${var.prjid}",
    "owner", var.email,
    "team", var.teamid,
    "project", var.prjid
  )
}
