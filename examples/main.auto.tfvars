azuread_user = {
  "admin@example.onmicrosoft.com"   = {
    surname             = "Administrator"
    given_name          = "Tenant"
    display_name        = "Administrator"
    user_principal_name = "admin@example.onmicrosoft.com"
    account_enabled     = true
    is_admin            = true
  }
  "john.doe@example.com"   = {
    surname             = "Doe"
    given_name          = "John"
    account_enabled     = true
    company_name        = "Example Corp"
    country             = "US"
    employee_hire_date  = "2025-04-12T01:12:23Z"
    state               = "Florida"
    postal_code         = "12345"
    city                = "Miami"
    street_address      = "Route 66"
    business_phones     = [ "+01 12 3456789", ]
    mobile_phone        = "+01 98 7654321"
    mail                = "john.doe@example.com"
    usage_location      = "US"
  }
}
