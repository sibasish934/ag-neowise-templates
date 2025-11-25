variable "name" {
  description = "Name of the MQ broker"
  type        = string
}

variable "engine_type" {
  description = "MQ engine type (ActiveMQ or RabbitMQ)"
  type        = string
  default     = "ActiveMQ"
}

variable "engine_version" {
  description = "MQ engine version"
  type        = string
  default     = "5.17.6"  # You can update this as per requirement
}

variable "instance_type" {
  description = "Instance type for MQ broker"
  type        = string
  default     = "mq.t3.micro"
}

variable "deployment_mode" {
  description = "Deployment mode: SINGLE_INSTANCE or ACTIVE_STANDBY_MULTI_AZ"
  type        = string
  default     = "SINGLE_INSTANCE"
}

variable "subnet_ids" {
  description = "List of subnet IDs for MQ"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where MQ will be deployed"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "CIDRs allowed to access MQ"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "publicly_accessible" {
  description = "Whether MQ broker is publicly accessible"
  type        = bool
  default     = false
}

variable "username" {
  description = "MQ username"
  type        = string
}

variable "password" {
  description = "MQ password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
