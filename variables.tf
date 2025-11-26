variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "prefix" {
  default = "neowise-app"
}

variable "project" {
  default = "neowise-payment-app"
}

variable "contact" {
  default = "infra-issues@neowise.com"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_list" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "instance_type" {
  default = "t2.medium"
}

variable "env" {
  type    = string
  default = "prod"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "Admin@123456"
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair for EC2 instances (must exist in AWS)"
  type        = string
  default     = null
}
