# Terrafrom-3tier-architecture
3-tier architecture deployment on AWS using Terraform 
I created the folder directory in the below format 

Terraform 
|
|---------Main.tf
|---------Outputs.tf
|---------Providers.tf
|---------vpc
          |---------vpc.tf
          |---------web.tf
          |---------Variables.tf
          |---------Outputs.tf

We need to initialize the Terraform in the Terraform folder.
Main.tf contains all the module values that will be passed while running the terraform commands
we have VPC.tf which contains all the necessary network Setup 
Web.tf has all the Required Servers, Load Balancer, and SG configuration in it 

Further Enhancements are possible...
