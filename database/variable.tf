variable "prefix" {}
variable "rds_sg_id" {}
variable "private_subnet_id" {}
variable "private_subnet_ids" {
  type = list(string)
  default = []
}
variable "common_tags" {}