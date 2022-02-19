<h1> Infra Provisioning </h1>

In this test, I use terraform to provision both infra and application setup. I decide to use aws vpc module to create a vpc 10.0.0.0/16 with one private subnet and two public subnets. Private subnet is used to create ec2 instance which will host nodejs app. One public subnet is for bastion host and another one is used to create an alb subnets. Also I enable nat gateway for private subnet internet access. This is my terraform resource to create vpc and subnet.
  
```bash
  module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.cidr_blocks

  azs             = var.azs             
  private_subnets = var.private_subnets 
  public_subnets  = var.public_subnets  

  enable_nat_gateway = true  

  tags = {
    Terraform   = "true"
  }
}
```
Next, I created three security groups named bastionSG, privateSG and albSG. I decide to use for_each and dynamic blocks for ingress rules to provision three security groups. local variable security_groups is defined in my locals.tf.

```bash
resource "aws_security_group" "awsdemo-sg" {
  for_each    = local.security_groups   
  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc.vpc_id


  #dynamic block for each ingress rule

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
Then I added two additional sg rule for privteSG. one is created to allow ssh from bastion host, another one is to allow traffic from alb sg.
```bash
resource "aws_security_group_rule" "privatesg-sshrule" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.awsdemo-sg["bastionSG"].id
  security_group_id        = aws_security_group.awsdemo-sg["privateSG"].id
}

# ---- sg rule to allow all traffic as alb sg source to privateSG (private ec2) ------

resource "aws_security_group_rule" "privatesg-albrule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.awsdemo-sg["albSG"].id
  security_group_id        = aws_security_group.awsdemo-sg["privateSG"].id
}
```
This is to create bastion host. I used existing key pair named aya here.
```bash
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = ["${aws_security_group.awsdemo-sg["bastionSG"].id}"]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name                    = var.aws_key_pair

  tags = {
    Name = "Bastion-EC2"
  }
}
```
After creating bastion host, I created private ec2 instance. I will also use terraform to install docker and run docker container inside this instance via bastion host.

```bash
# ----- provision private ec2 -------------

resource "aws_instance" "private" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.awsdemo-sg["privateSG"].id}"]
  subnet_id              = module.vpc.private_subnets[0]
  key_name               = var.aws_key_pair
  depends_on             = [aws_eip.bastion]

  tags = {
    Name = "Private-EC2"
  }
  connection {                    # to run docker commands inside private ec2 
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/Downloads/aya.pem")
    host        = self.private_ip

    bastion_host        = aws_eip.bastion.public_ip
    bastion_host_key    = var.aws_key_pair
    bastion_port        = 22
    bastion_user        = "ubuntu"
    bastion_private_key = file("~/Downloads/aya.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "git clone https://github.com/thaunghtike-share/nodejs.git",
      "cd nodejs && sudo docker build -t nodejsdemo:1.0.0 .",
      "sudo docker run -d -p 2019:2019 nodejsdemo:1.0.0"   ]
  }
}
```
After two instances creating, next step is to create an alb, alb listener and target group. ALB listener port is 80 and target group port is 2019.

```bash
# ------------ aws alb create -----------

resource "aws_lb" "demo" {
  name            = "demoalb"
  subnets         = module.vpc.public_subnets
  security_groups = ["${aws_security_group.awsdemo-sg["albSG"].id}"]
  idle_timeout    = 400
}
# ---------- alb target group -----------

resource "aws_lb_target_group" "demotg" {
  name     = "demotg"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = module.vpc.vpc_id
  health_check {
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
    timeout             = var.elb_timeout
    interval            = var.elb_interval
  }
}

# ----------- alb listener on port 80 ------------

resource "aws_lb_listener" "demolistener" {        
  load_balancer_arn = aws_lb.demo.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demotg.arn
  }
} 
```
Then, to add private ec2 instance to this target group.

```bash
# ------- add private ec2 to target group --------

resource "aws_lb_target_group_attachment" "demo" {
  target_group_arn = aws_lb_target_group.demotg.arn
  target_id        = aws_instance.private.id
  port             = var.tg_port
}
```
The final step is create alb listener rules to allow only 116.206.137.18 to /admin path. So, I create first rule to return 403 to all ips.

```bash
# --------- alb listener rules to allow only 116.206.137.18 to /admin path ------

resource "aws_lb_listener_rule" "rule1" {
  listener_arn = aws_lb_listener.demolistener.arn
  priority     = 100

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden"
      status_code  = "403"
    }
  }  
  condition {
    path_pattern {
      values = ["/admin"]
    }
  }
}
```
Second Rule is to allow /admin path when source ip is 116.206.137.18. I use lower priority number than rule1 to effect this rule to alb.

```bash
resource "aws_lb_listener_rule" "rule2" {
  listener_arn = aws_lb_listener.demolistener.arn
  priority     = 90

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.demotg.arn
  }  
  condition {
    path_pattern {
      values = ["/admin"]
    }
  }
  condition {
    source_ip {
      values = ["${var.adminip}"]
    }
  }
}
```

these two variables: mypublicip is used to allow ssh to bastion host in bastionSG and adminip var is used to allow access to /admin path.

```bash
variable "mypublicip" {    # to allow ssh to bastion host from my public ip
  type        = string
  description = "my public ip "
  default     = "210.14.105.0/24"
}

variable "adminip" {   # public ip to allow access to /admin url 
  type = string
  default = "116.206.137.0/24"
}
```

