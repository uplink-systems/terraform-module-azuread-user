####################################################################################################
#   terraform.tf                                                                                   # 
####################################################################################################

terraform {
  required_providers {
    azuread = {
      source  = "registry.terraform.io/hashicorp/azuread"
      version = "~> 3.4"
    }
    local = {
      source = "registry.terraform.io/hashicorp/local"
    }
    random = {
      source = "registry.terraform.io/hashicorp/random"
    }
  }
}
