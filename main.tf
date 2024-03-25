provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
  vpc_variables = {
    vpc1 = {
      cidr_block = "10.0.0.0/16"
      tags       = { "Name" : "vpc_anant" }
    }
  }
  pub_sub_variables = {
    public_subnet = {
      cidr_block        = "10.0.1.0/24"
      vpc_name          = "vpc1"
      availability_zone = "us-east-1a"
      tags              = { "Name" : "pub_sub_test" }
    }
    public_subnet_2 = {
      cidr_block        = "10.0.3.0/28"
      vpc_name          = "vpc1"
      availability_zone = "us-east-1b"
      tags              = { "Name" : "pub_sub_test_2" }
    }
    private_subnet = {
      cidr_block        = "10.0.4.0/24"
      vpc_name          = "vpc1"
      availability_zone = "us-east-1c"
      tags              = { "Name" : "pri_sub_test" }
    }
    private_subnet_1 = {
      cidr_block        = "10.0.7.0/24"
      vpc_name          = "vpc1"
      availability_zone = "us-east-1c"
      tags              = { "Name" : "rds_subnet" }
    }

  }
  
  /*pri_sub_variables = {
    private_subnet = {
      cidr_block        = "10.0.4.0/24"
      vpc_name          = "vpc1"
      availability_zone = "us-east-1b"
      tags              = { "Name" : "pri_sub_test" }
    }

  }*/
  igw_variables = {
    igw1 = {
      vpc_name = "vpc1"
      tags     = { "Name" : "igw" }
    }
  }
  rt_variables = {
    rt1 = {
      vpc_name = "vpc1"
      routes = [{
        cidr_block = "0.0.0.0/0"
        gateway_id = "igw1"
        }
      ]
      tags = {
        "Name"        = "rtb"
        "Environment" = "production"
      }
    }
  }
  rt_association_variables = {
    assoc1 = {
      subnet_name = "public_subnet"
      rt_name     = "rt1"
      tags        = { "Name" : "rtb_assoc" }
    }
  }
  nacl_variables = {
    nacl_new = {
      vpc_name = "vpc1"
      tags = {
        "Name" = "nacl_vpc1"
      }
    }
  }


  nat_gateway_variables = {
    nat_gat = {
      subnet_name = "private_subnet"
      tags = {
        "Name" = "nat_gateway"
      }
    }
  }

    security_group_variables = {
    web_sg_group = {
      description         = "This is the demo security group for the sg"
      vpc_name            = "vpc1"
      ingress_port        = 80
      ingress_protocol    = "tcp"
      ingress_cidr_blocks = ["0.0.0.0/0"]
      egress_port         = 443
      egress_protocol     = "tcp"
      egress_cidr_blocks  = ["0.0.0.0/0"]
      tags = {
        "Name" = "Web_sg"
      }
    }
    app_sg_group = {
      description         = "This is the demo security group for the app sg"
      vpc_name            = "vpc1"
      ingress_port        = 80
      ingress_protocol    = "tcp"
      ingress_cidr_blocks = ["0.0.0.0/0"]
      egress_port         = 443
      egress_protocol     = "tcp"
      egress_cidr_blocks  = ["0.0.0.0/0"]
      tags = {
        "Name" = "app_sg"
      }
    }
    
  }
  ec2_instance_variables = {
    public_instance_1 = {
      ami_id              = "ami-0c101f26f147fa7fd"
      instance_type       = "t2.micro"
      subnet_name         = "public_subnet"
      security_group_name = ["web_sg_group"]
      key_name            = "webserver-key"
      tags = {
        "Name" = "web_server_1"
      }
    }
    public_instance_2 = {
      ami_id              = "ami-0c101f26f147fa7fd"
      instance_type       = "t2.micro"
      subnet_name         = "public_subnet"
      security_group_name = ["web_sg_group"]
      key_name            = "webserver-key"
      tags = {
        "Name" = "web_Server_2"
      }
    }
    private_instance = {
      ami_id              = "ami-0c101f26f147fa7fd"
      instance_type       = "t2.micro"
      subnet_name         = "private_subnet"
      security_group_name = ["app_sg_group"]
      key_name            = "webserver-key"
      tags = {
        "Name" = "application_instance"
      }
    }
    
  }

alb_variables={
  pubic_alb= {
    name               = "public-app-load-balancer"
    internal           = false
    load_balancer_type = "application"
    security_group_name    = ["web_sg_group"]
    subnet_name        = ["public_subnet","public_subnet_2"]
    tags               = {
      "Name"="pub_Alb"
    }
  }
}

}
