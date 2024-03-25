output "vpcs" {
  description = "VPC Outputs"
  value       = { for vpc in aws_vpc.my_vpc : vpc.tags.Name => { "cidr_block" : vpc.cidr_block, "id" : vpc.id } }
}

output "subnets" {
  description = "Public Subnet"
  value       = { for sub in aws_subnet.my_sub_pub : sub.tags.Name => { "cidr_block" : sub.cidr_block, "id" : sub.id } }
}
/*output "private_sub" {
  description = "Private Subnet"[]
  value       = { for sub in aws_subnet.my_sub_pri : sub.tags.Name => { "cidr_block" : sub.cidr_block, "id" : sub.id } }
}
*/

output "my_nacl" {
  description = "Nacl for VPC1"
  value       = { for nac in aws_network_acl.my_nacl :nac.tags.Name => {  "id" : nac.id } }
}

output "my_instance" {
  description = "Private Instance  for VPC1"
  value       = { for instance in aws_instance.my_instance :instance.tags.Name => {  "id" : instance.id } }
}
