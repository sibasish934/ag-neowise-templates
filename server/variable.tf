variable "prefix" {}
variable "common_tags" {}
variable "private_subnet_id" {}

variable "public_subnet_id" {}

variable "private_sg_id" {}

variable "public_sg_id" {}

variable "ami" {}

variable "instance_type" {}

variable "ssh_key_name" {
  description = "Name of the SSH key pair for EC2 instances"
  type        = string
  default     = null
}