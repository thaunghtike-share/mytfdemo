# ----- security groups local variable ------

locals {
  security_groups = {
    bastionSG = {
      name        = "bastionSG"
      description = "security group for bastion host"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.all_ip]   
        }
      }
    }
    privateSG = {
      name        = "privateSG"
      description = "security group for app server"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.all_ip]
        }
      }
    }
    albSG = {
      name        = "albSG"
      description = "security group for alb"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.all_ip]
        }
      }
    }
  }
}


