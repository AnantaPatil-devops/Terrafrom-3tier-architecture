output "vpcs" {
  value = module.vpc.vpcs
}

output "subnets"{
    value = module.vpc.subnets 
}
/*output "private_sub"{
    value = module.vpc.private_sub
}
*/
output "my_nacl"{
    value = module.vpc.my_nacl
}

output "my_instance"{
    value = module.vpc.my_instance
}

