####################################################################################################
# Author: Dipaditya Das | www.github.com/DipadityaDas | https://www.linkedin.com/in/dipadityadas/  #
# This Project has GPLv3.0 Licence be very carefull with editing and copying the Code.             #
####################################################################################################

terraform {
  required_providers {
	aws = {
	  source = "hashicorp/aws"
	  version = "3.46.0"
	}
  }
}

# Change the Profile Accordingly
provider "aws" {
  profile = "default" 
  region = var.aws_region
}