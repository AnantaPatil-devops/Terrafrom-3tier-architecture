variable "vpc_variables" {
  description = "VPC parameters"
  type = map(object({
    cidr_block = string
    tags       = map(string)
  }))
  default = {}
}


variable "pub_sub_variables" {
  description = "Subnet parameters"
  type = map(object({
    cidr_block        = string
    vpc_name          = string
    availability_zone = string
    tags              = map(string)
  }))
  default = {}
}
variable "pri_sub_variables" {
  description = "Subnet parameters"
  type = map(object({
    cidr_block = string
    vpc_name   = string
    availability_zone = string
    tags       = map(string)
  }))
  default = {}
}
variable "igw_variables" {
  description = "IGW parameters"
  type = map(object({
    vpc_name = string
    tags     = map(string)
  }))
  default = {}
}


variable "rt_variables" {
  description = "RT parameters"
  type = map(object({
    vpc_name = string
    tags     = map(string)
    routes = optional(list(object({
      cidr_block = string
      use_igw    = optional(bool, true)
      gateway_id = string
    })), [])
  }))
  default = {}
}
variable "rt_association_variables" {
  description = "RT association parameters"
  type = map(object({
    subnet_name = string
    rt_name     = string
  }))
  default = {}
}

variable "nacl_variables" {
  type = map(object({
    vpc_name = string
    tags     = map(string)
  }))
}

variable "nat_gateway_variables" {
  type = map(object({
    subnet_name = string
    tags = map(string)
  }))
  
}
 
variable "ec2_instance_variables" {
  description = "Map of EC2 instance configurations"
  type        = map(object({
    ami_id         = string
    instance_type  = string
    subnet_name     = string
    key_name       = string
    security_group_name= list(string)
    tags           = map(string)
  }))
}

variable "security_group_variables" {
  description = "Security group configurations"
  type = map(object({
    description           = string
    vpc_name              = string
    ingress_port          = number
    ingress_protocol      = string
    ingress_cidr_blocks   = list(string)
    egress_port           = number
    egress_protocol       = string
    egress_cidr_blocks    = list(string)
    tags                  = map(string)
  }))

}

variable "alb_variables" {
  description = "AWS Application Load Balancer configurations"
  type        = map(object({
    name               = string
    internal           = bool
    load_balancer_type = string
    security_group_name    = list(string)
    subnet_name        = set(string)
    tags               = map(string)
  }))

}
