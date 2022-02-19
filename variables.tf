# --- root/variables.tf ---

variable "all_ip" {
  type        = string
  description = "all ip addresses"
  default     = "0.0.0.0/0"
}

variable "azs" {
  type        = list(string)
  description = "azs for vpc"
}

variable "private_subnets" {
  type        = list(string)
  description = "private subnet"
}

variable "public_subnets" {
  type        = list(string)
  description = "public subnets"
}

variable "public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcRFuqChikaltTCnmBVpVMwJbpClapk3Zpy/sVPTol3jYXe4+FVSscYIw2cCmMDeihLu2n2rBwARFmxC39cHVLUC6YQUih7Nw1gSIha5dPQcVs1p0SFMpRPFEKsz8T7QltPhJyevTx7V9F2j/dnIEOCNtnvXMjzA3E2K5NCrmoZXVnK8dQLdb39e74URMme/wrcJA95eszlkHwZqLs73WnFsiMEUaLEGtFD2P6+TvbwYrbn7lrc0MHG5T9cGRDSE/09/yWekLzAhTyVwapKTxc3pvNbq4ik3FPc6oQbEoHw+IQr/iwDGERDGcDlnngNB60B5LXAenjjgjf1l//SBHnajuiFlr2OgAQCidS0Vk69sRFHCT9UP0XDJlk5yty4+9jbB2U8ekMmpUEFAq8wIdSJNqyKJ8+Ol0nwR0grMOv+qKw0VO+Wv//BeObZB7HG5BKQf634zLTmbttyfDgP7MS1CnqOhRQ6VL5MahcjO7zo/hdvk1nSceOAhy4xursEqk= swezinlinn@Swes-MacBook-Pro.local"
  description = "my public key"
}
variable "cidr_blocks" {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "ami" {
  type        = string
  default     = "ami-04505e74c0741db8d"
  description = "ubuntu 20 ami id"
}

variable "instance_type" {
  type        = string
  default     = "t2.small"
  description = "ec2 instance type"
}

variable "tg_port" {
  type        = number
  default     = 2019
  description = "target gp port number"
}

variable "tg_protocol" {
  type        = string
  default     = "HTTP"
  description = "target group protocol"
}

variable "elb_healthy_threshold" {
  type    = number
  default = 5
}

variable "elb_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "elb_timeout" {
  type    = number
  default = 5
}

variable "elb_interval" {
  type    = number
  default = 30
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "adminip" { # public ip to allow access to /admin url 
  type    = string
  default = "116.206.137.18/32"
}
