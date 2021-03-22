# Additional documentation: https://www.terraform.io/docs/configuration/variables.html
variable "email" {
  description = "email address to be used for tagging (suggestion: use group email address)"
}

variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
}

variable "profile_to_use" {
  description = "Getting values from ~/.aws/credentials"
  default     = "default"
}

variable "performance_mode" {
  description = "The performance mode of your file system."
  type        = string
  default     = "generalPurpose"
}

variable "security_groups_to_use" {
  description = "Security Groups"
  type        = list(any)
}

variable "encrypted" {
  description = "vpc_id_to_use"
  default     = true
}

variable "account_id" {
  description = "AWS account id (used to pull values from shared base module like vpc info, subnet ids)"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "deploy_efs" {
  description = "feature flag, true or false"
  default     = true
  type        = bool
}

variable "subnets" {
  default     = []
  description = "Subnet IDs that the EFS mount points should be created on (required if `create==true`)"
  type        = list(string)
}

variable "transition_to_ia" {
  type        = string
  description = "Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS"
  default     = ""
}

variable "mount_target_ip_address" {
  type        = string
  description = "The address (within the address range of the specified subnet) at which the file system may be mounted via the mount target"
  default     = null
}

variable "access_points" {
  type        = map(map(map(any)))
  default     = {}
  description = "A map of the access points you would like in your EFS volume"
}