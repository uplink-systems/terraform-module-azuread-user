####################################################################################################
#   local.tf                                                                                       #
####################################################################################################

locals {
  surname               = lower(join("", [for character in split("", var.user.surname): lookup(var.character_map, character, character)]))
  given_name            = lower(join("", [for character in split("", var.user.given_name): lookup(var.character_map, character, character)]))
  domain_name           = var.user.is_admin == false ? data.azuread_domains.default.domains.0.domain_name : data.azuread_domains.initial.domains.0.domain_name
  display_name          = var.user.is_admin == false ? format("%s, %s", var.user.surname, var.user.given_name) : format("%s, %s - Administrator", var.user.surname, var.user.given_name)
  user_principal_name   = var.user.is_admin == false ? format("%s.%s@%s", local.given_name, local.surname, local.domain_name) : format("admin.%s.%s@%s", local.given_name, local.surname, local.domain_name)
  mail                  = var.user.is_admin == false ? format("%s.%s@%s", local.given_name, local.surname, local.domain_name) : null
  mail_nickname         = var.user.is_admin == false ? format("%s.%s", local.given_name, local.surname) : null
  export                = {
    filename              = (
      var.user.export.path != null && var.user.export.file != null ? "${var.user.export.path}/${var.user.export.file}" : (
        var.user.export.path == null && var.user.export.file != null ? "${path.root}/files/export/${var.user.export.file}" : (
          var.user.export.path != null && var.user.export.file == null ? "${var.user.export.path}/${local.surname}_${local.given_name}.txt" : (
            "${path.root}/files/export/${local.surname}_${local.given_name}.txt"
          )
        )
      )
    )
  }
  password  = {
    length            = {
      admin             = try(var.password.length, 16) >= 16 ? try(var.password.length, 16) : 16
      user              = try(var.password.length, 12) >= 12 ? try(var.password.length, 12) : 12
    }
    lower             = try(var.password.lower, true)
    min_lower         = try(var.password.min_lower, 1)
    min_numeric       = try(var.password.min_numeric, 1)
    min_special       = try(var.password.min_special, 1)
    min_upper         = try(var.password.min_upper, 1)
    numeric           = try(var.password.numeric, true)
    override_special  = try(var.password.override_special, "!#$%&*()-_=+[]{}<>:?")
    special           = try(var.password.special, true)
    upper             = try(var.password.upper, true)
  }
}
