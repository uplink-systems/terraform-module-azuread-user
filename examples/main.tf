####################################################################################################
#   main.tf                                                                                        #
####################################################################################################

variable "azuread_user" {
  description    = "variable declaration for 'azuread_user' module"
}
module "azuread_user" {
  source                      = "github.com/uplink-systems/terraform-module-azuread-user"
  for_each                    = {for k, v in var.azuread_user : k => v if var.execute.azuread_user}
  user                        = each.value
}
