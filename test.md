<!-- BEGIN_TF_DOCS -->
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.12.0 |

### Resources

| Name | Type |
|------|------|
| [aws_eip.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.tfdemo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_lb.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.demolistener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.rule1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.rule2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.demotg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.awsdemo-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.privatesg-albrule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.privatesg-sshrule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adminip"></a> [adminip](#input\_adminip) | n/a | `string` | `"116.206.137.18/32"` | no |
| <a name="input_all_ip"></a> [all\_ip](#input\_all\_ip) | all ip addresses | `string` | `"0.0.0.0/0"` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | ubuntu 20 ami id | `string` | `"ami-04505e74c0741db8d"` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | azs for vpc | `list(string)` | n/a | yes |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | vpc cidr block | `string` | `"10.0.0.0/16"` | no |
| <a name="input_elb_healthy_threshold"></a> [elb\_healthy\_threshold](#input\_elb\_healthy\_threshold) | n/a | `number` | `5` | no |
| <a name="input_elb_interval"></a> [elb\_interval](#input\_elb\_interval) | n/a | `number` | `30` | no |
| <a name="input_elb_timeout"></a> [elb\_timeout](#input\_elb\_timeout) | n/a | `number` | `5` | no |
| <a name="input_elb_unhealthy_threshold"></a> [elb\_unhealthy\_threshold](#input\_elb\_unhealthy\_threshold) | n/a | `number` | `2` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | ec2 instance type | `string` | `"t2.small"` | no |
| <a name="input_listener_port"></a> [listener\_port](#input\_listener\_port) | n/a | `number` | `80` | no |
| <a name="input_listener_protocol"></a> [listener\_protocol](#input\_listener\_protocol) | n/a | `string` | `"HTTP"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | private subnet | `list(string)` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | my public key | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcRFuqChikaltTCnmBVpVMwJbpClapk3Zpy/sVPTol3jYXe4+FVSscYIw2cCmMDeihLu2n2rBwARFmxC39cHVLUC6YQUih7Nw1gSIha5dPQcVs1p0SFMpRPFEKsz8T7QltPhJyevTx7V9F2j/dnIEOCNtnvXMjzA3E2K5NCrmoZXVnK8dQLdb39e74URMme/wrcJA95eszlkHwZqLs73WnFsiMEUaLEGtFD2P6+TvbwYrbn7lrc0MHG5T9cGRDSE/09/yWekLzAhTyVwapKTxc3pvNbq4ik3FPc6oQbEoHw+IQr/iwDGERDGcDlnngNB60B5LXAenjjgjf1l//SBHnajuiFlr2OgAQCidS0Vk69sRFHCT9UP0XDJlk5yty4+9jbB2U8ekMmpUEFAq8wIdSJNqyKJ8+Ol0nwR0grMOv+qKw0VO+Wv//BeObZB7HG5BKQf634zLTmbttyfDgP7MS1CnqOhRQ6VL5MahcjO7zo/hdvk1nSceOAhy4xursEqk= swezinlinn@Swes-MacBook-Pro.local"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | public subnets | `list(string)` | n/a | yes |
| <a name="input_tg_port"></a> [tg\_port](#input\_tg\_port) | target gp port number | `number` | `2019` | no |
| <a name="input_tg_protocol"></a> [tg\_protocol](#input\_tg\_protocol) | target group protocol | `string` | `"HTTP"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | n/a |
<!-- END_TF_DOCS -->