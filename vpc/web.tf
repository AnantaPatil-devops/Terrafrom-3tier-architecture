resource "aws_security_group" "my_security_group" {
  for_each      = var.security_group_variables
  name          = each.key
  description   = each.value.description
  vpc_id        = aws_vpc.my_vpc[each.value.vpc_name].id


  ingress {
    from_port   = each.value.ingress_port
    to_port     = each.value.ingress_port
    protocol    = each.value.ingress_protocol
    cidr_blocks = each.value.ingress_cidr_blocks
  }

  // Define egress rules here
  egress {
    from_port   = each.value.egress_port
    to_port     = each.value.egress_port
    protocol    = each.value.egress_protocol
    cidr_blocks = each.value.egress_cidr_blocks
  }

  tags = each.value.tags
}
resource "aws_instance" "my_instance" {
  for_each       = var.ec2_instance_variables
  ami            = each.value.ami_id
  instance_type  = each.value.instance_type
  subnet_id   = aws_subnet.my_sub_pub[each.value.subnet_name].id
  #security_groups = [aws_security_group.my_security_group[each.value.security_group_name].id]
  security_groups = [aws_security_group.my_security_group[each.value.security_group_name[0]].id]

  key_name       = each.value.key_name
  tags           = each.value.tags
}

resource "aws_lb" "my_alb" {
  for_each           = var.alb_variables
  name               = each.value.name
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  security_groups = [aws_security_group.my_security_group[each.value.security_group_name[0]].id]
  subnets            = [for subnet_name in each.value.subnet_name : aws_subnet.my_sub_pub[subnet_name].id]
  tags = each.value.tags
}
