<h1> Infra Provisioning <h1>

In this test, I use terraform to provision both infra and application setup. I decide to use aws vpc module to create a pvc 10.0.0.0/16 with one private subnet and two public subnets. Private subnet is used to create ec2 instance which will host nodejs app. One public subnet is for bastion host and another one is used to create an alb subnets. This is my terraform resource to create vpc and subnet.
  
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
  
