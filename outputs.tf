# --- root/outputs.tf ---

output "sg_id" {
  value = aws_security_group.awsdemo-sg["bastionSG"].id
}
