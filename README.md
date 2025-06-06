## Module 'terraform-module-azuread-user'

### Description

The module **terraform-module-azuread-user** is intended to create Cloud-only user accounts in Azure AD with 'user_type' *Member* following my business needs and standards. The module manages user accounts and admin accounts and scopes all attributes available in the provider. It is designed to handle multiple users or even all users using for_each loop in the root module.  
  
The module uses the following guidelines:  
* Users
  * User UPNs always use the primary domain as their UPN suffix
  * Admin UPNs always use the initial domain as their UPN suffix
  
> [!WARNING]
>The module's outputs may expose sensitive data like user credentials in the CLI as well as in the file system.  
>Therefore it should only be used by trusted admins and store its output to highly restricted locations.  

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [hashicorp\/azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_local"></a> [hashicorp\/local](#requirement\_local) | ~> 2.5 |
| <a name="requirement_random"></a> [hashicorp\/random](#requirement\_random) | ~> 3.6 |

### Resources

| Name | Type |
|------|------|
| [azuread_user.user](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |
| [local_sensitive_file.credential](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_user"></a> [user](#input\_user) | 'var.user' is the main variable for azuread_user resource settings | <pre>type = object({<br>  given_name                  = string<br>  surname                     = string<br>  display_name                = optional(string, null)<br>  user_principal_name         = optional(string, null)<br>  account_enabled             = optional(bool, true)<br>  force_password_change       = optional(bool, true)<br>  disable_password_expiration = optional(bool, false)<br>  disable_strong_password     = optional(bool, false)<br>  is_admin                    = optional(bool, false)<br>  preferred_language          = optional(string, "en-US")<br>  usage_location              = optional(string, null)<br>  mail_nickname               = optional(string, null)<br>  mail                        = optional(string, null)<br>  other_mails                 = optional(list(string), [])<br>  show_in_address_list        = optional(bool, true)<br>  employee_id                 = optional(string, null)<br>  employee_type               = optional(string, null)<br>  job_title                   = optional(string, null)<br>  company_name                = optional(string, null)<br>  division                    = optional(string, null)<br>  department                  = optional(string, null)<br>  cost_center                 = optional(string, null)<br>  manager_id                  = optional(string, null)<br>  sponsors                    = optional(list(string), [])<br>  country                     = optional(string, null)<br>  state                       = optional(string, null)<br>  postal_code                 = optional(string, null)<br>  city                        = optional(string, null)<br>  street_address              = optional(string, null)<br>  office_location             = optional(string, null)<br>  business_phones             = optional(list(string), [])<br>  mobile_phone                = optional(string, null)<br>  fax_number                  = optional(string, null)<br>  parental_control            = optional(object({<br>    enabled                     = optional(bool, true)<br>    age_group                   = optional(string, null)<br>    consent_provided_for_minor  = optional(string, null)<br>  }), { enabled = false })<br>  export                    = optional(object({<br>    enabled                     = optional(bool, true)<br>    file                        = optional(string, null)<br>    path                        = optional(string, null)<br>  }), { enabled = true })<br>})<br></pre> | none | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_azuread_user"></a> [azuread\_user](#output\_azuread\_user) | list of all exported attributes values from all users |
| <a name="output_azuread_user_credential"></a> [azuread\_user\_credential](#output\_azuread\_user\_credential) | list of exported azuread_user.user.user_principal_name, random_password.password.result and local_sensitive_file.credential[0].filename attribute values as map from all users |
| <a name="output_azuread_user_credential_csv"></a> [azuread\_user\_credential\_csv](#output\_azuread\_user\_credential\_csv) | list of exported azuread_user.user_principal_name and random_password.password.result attribute values as comma-separated values from all users |

>[!IMPORTANT]
>Apart from that the module exports each user's username and passwort physically as text file by default using 'local_sensitive_file' resources (export can be prevented by setting *var.user.export.enabled* value to 'false'). Path and filename have default values but can be modified by configuring *var.user.export.path* and *var.user.export.file* (see section \"Variables / Locals\").

<details>
<summary><b>Using module output in root module</b></summary>

##### Examples

Output - UPNs of all users using 'azuread_user' output:  

```
output "azuread_user_user_principal_name" {
  value   = values(module.azuread_user).*.azuread_user.user_principal_name
}
```

Output - Credential details of all users using 'azuread_user_credential' output:

```
output "azuread_user_credentials" {
  value   = values(module.azuread_user).*.azuread_user_credential
}
```
</details>

### Known Issues

Known issues are documented with the GitHub repo's issues functionality. Please filter the issues by **Types** and select **Known Issue** to get the appropriate issues and read the results carefully before using the module to avoid negative impacts on your infrastructure.  
  
<a name="known_issues"></a> [list of Known Issues](https://github.com/uplink-systems/terraform-module-azuread-user/issues?q=type%3A%22known%20issue%22)

## Notes

### Variables / Locals

#### 'var.user.given_name'

The value for *var.user.given_name* is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'display_name', 'user_principal_name', 'mail' and 'mail_nickname' attributes. *local.given_name* transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.surname'

The value for *var.user.surname* is mandatory. Besides setting the value as user's 'given_name' attribute it is used in auto-build rules for 'displayal_name'_name', 'user_princip, 'mail' and 'mail_nickname' attributes. *local.surname* transforms German special characters like 'ä', 'ö', 'ü' and 'ß' to common non-special characters and replaces spaces with a dot.   

#### 'var.user.display_name'

The value for *var.user.display_name* is optional. The module has auto-build rules for default users' and admin users' *var.user.display_name* as *local.display_name* using the provided *var.user.surname*/*var.user.given_name* values (and appends a markup string for admins). 
Therefore, *var.user.display_name* must be specified only if the rule shall not apply.  

#### 'var.user.user_principal_name'

The value for *var.user.user_principal_name* is optional. The module has auto-build rules for default users' and admin users' *var.user.user_principal_name* as *local.user_principal_name* using the created *local.given_names*, *local.surname* and *local.domain_name* values (and prepends a markup string for admins). 
Therefore, *var.user.user_principal_name* must be specified only if the rule shall not apply.  

#### 'var.user.mail'

The value for *var.user.mail* is optional. The module has auto-build rules for default users' and admin users' *var.user.mail* as *local.mail* using the created *local.given_names*, *local.surname* and *local.domain_name* values (and prepends a markup string for admins). 
Therefore, *var.user.mail* must be specified only if the rule shall not apply.    

#### 'var.user.mail_nickname'

The value for *var.user.mail_nickname* is optional. The module has auto-build rules for default users' and admin users' *var.user.mail_nickname* as *local.mail_nickname* using the created *local.given_names*, *local.surname* and *local.domain_name* values (and prepends a markup string for admins). 
Therefore, *var.user.mail_nickname* must be specified only if the rule shall not apply.  

#### 'var.user.manager_id'

The value for *var.user.member_id* is optional and represents a user principal names for the user's manager. The module translates the user principal name to its corresponding object ID via data query.

#### 'var.user.sponsors'

The value for *var.user.sponsors* is optional and represents one or more user principal names for the account's sponsorship. Sponsorship is required only for admin accounts. The module translates the user principal names to their corresponding object ID via data query.  

#### 'var.user.is_admin'

The value for *var.user.is_admin* (true/false) is used to force the use of admin-related values for some attributes:  

* 'random_string.password.length' --> force value '16' instead of default value '12'  
* 'azuread_user.user.disable_strong_password' -> force value 'false'  
* 'azuread_user.user.show_in_address_list' --> force value 'false'  
* 'azuread_user.user.manager_id' --> force value 'null'  
* 'local.domain_name' --> force 'initial' domain as domain suffix  
* ... and more ...  

#### 'var.user.export'

The value of *var.user.export.enabled* specifies if the module exports the user's credentials to an output file (true) or not (false). The default value is 'true' if no other value is provided. The values for *var.user.export.path* and *var.user.export.file* represent the path and name of the credential export file to create. The module has a default value \"${path.root}/files/export/azuread/user\" for *var.user.export.path* and an auto-build rule for *var.user.export.file* using the created *local.given_names*, *local.surname* values.
Therefore, *var.user.export.enabled* must be specified only if credentials shall not be exported and *var.user.export.path* and/or *var.user.export.file* only if the value/rule shall not apply.  

**'var.user.export.path'**  
The value for *var.user.export.path* must be in Unix style (using forward slashes) even if Terraform is running on Windows.  
Examples for valid paths:  

<pre>
/terraform/files/output
./terraform/files/output
../terraform/files/output
C:/terraform/files/output
</pre>
