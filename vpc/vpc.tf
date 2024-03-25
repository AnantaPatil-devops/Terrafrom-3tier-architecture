resource "aws_vpc" "my_vpc" {
  for_each             = var.vpc_variables
  cidr_block           = each.value.cidr_block
  tags = each.value.tags
}

resource "aws_subnet" "my_sub_pub" {
  for_each   = var.pub_sub_variables
  vpc_id     = aws_vpc.my_vpc[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

   tags = each.value.tags
}
/*
resource "aws_subnet" "my_sub_pri" {
  for_each   = var.pri_sub_variables
  vpc_id     = aws_vpc.my_vpc[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
   tags = each.value.tags
}
*/

resource "aws_internet_gateway" "igw" {
  for_each = var.igw_variables
  vpc_id   = aws_vpc.my_vpc[each.value.vpc_name].id
    tags = each.value.tags
}

resource "aws_route_table" "aws_rtb" {
  for_each = var.rt_variables
  vpc_id   = aws_vpc.my_vpc[each.value.vpc_name].id
    tags = each.value.tags

  dynamic "route" {
    for_each = each.value.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.use_igw ? aws_internet_gateway.igw[route.value.gateway_id].id : route.value.gateway_id
    }
  }
}

resource "aws_route_table_association" "rtb_table" {
  for_each       = var.rt_association_variables
  subnet_id      = aws_subnet.my_sub_pub[each.value.subnet_name].id
  route_table_id = aws_route_table.aws_rtb[each.value.rt_name].id
}

resource "aws_network_acl" "my_nacl" {
  for_each  = var.nacl_variables
  vpc_id    = aws_vpc.my_vpc[each.value.vpc_name].id
  tags = each.value.tags
} 

resource "aws_nat_gateway" "nat_gateway" {
  for_each    = var.nat_gateway_variables
  subnet_id   = aws_subnet.my_sub_pub[each.value.subnet_name].id
    allocation_id = aws_eip.nat_eip[each.key].id
  tags = each.value.tags
}

resource "aws_eip" "nat_eip" {
  for_each = var.nat_gateway_variables
}
