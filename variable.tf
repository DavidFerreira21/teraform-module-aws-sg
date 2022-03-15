# obrigatoria
variable "sg_name" {
  description = "name for SG"
  type    = string
  default = ""
}

variable "sg_description" {
  description = "Description for SG"
  type    = string
  default = ""
}

# obrigatoria
variable "vpc_id" {
  description = "vpc id for SG"
  type = string
}

variable "tags" {
  description = "Maps of tags"
  type    = map(any)
  default = {}

}

variable "rules_sg" {
  description = "Maps of rules for SG , this variable is use just with attribute source_security_group_id (not work with cidr_blocks) "
  type        = map(map(any))
  default     = {}
}

variable "rules_cidr" {
  description = "Maps of rules for SG , this variable is use just with attribute cidr_blocks (not work with source_security_group_id)"
  type        = map(map(any))
  default     = {}
}
