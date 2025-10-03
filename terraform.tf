terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }

  /* Uncomment this block to use Terraform Cloud for this tutorial
  cloud {
    organization = "organization-name"
    workspaces {
      name = "learn-terraform-init"
    }
  }
*/
}
