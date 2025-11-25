variable "region" {
  type    = string
  default = "us-east-1"
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
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_type" {
  default = "t2.medium"
}

variable "env" {
  type    = string
  default = "uat"
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
  default = "admin@123"
}
