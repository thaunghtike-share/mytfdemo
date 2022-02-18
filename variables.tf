# --- root/variables.tf ---

variable "mypublicip" {    # to allow ssh to bastion host from my public ip
  type        = string
  description = "my public ip "
  default     = "210.14.105.0/24"
}

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

variable "aws_key_pair" {
  type        = string
  default     = "aya"
  description = "aya key pair"
}

variable "cidr_blocks" {
  type = string
  default = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "ami" {
  type = string
  default = "ami-04505e74c0741db8d"
  description = "ubuntu 20 ami id"
}

variable "instance_type" {
  type = string
  default = "t2.small"
  description = "ec2 instance type"
}

variable "tg_port" {
  type = number
  default = 2019
  description = "target gp port number"
}

variable "tg_protocol" {
  type = string
  default = "HTTP"
  description = "target group protocol"
}

variable "elb_healthy_threshold" {
  type = number
  default = 5
}

variable "elb_unhealthy_threshold" {
  type = number
  default = 2
}

variable "elb_timeout" {
  type = number
  default = 5  
}

variable "elb_interval" {
  type = number
  default = 30
}

variable "listener_port" {
  type = number
  default = 80
}

variable "listener_protocol" {
  type = string
  default = "HTTP"
}

variable "adminip" {   # public ip to allow access to /admin url 
  type = string
  default = "116.206.137.0/24"
}