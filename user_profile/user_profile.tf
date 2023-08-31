# Manage a user profile.. This TF will create a user profile.
terraform {
  required_providers {
    prismacloud = {
      source = "PaloAltoNetworks/prismacloud"
      version = "1.4.5"
    }
  }
}

provider "prismacloud" {
    #url = var.url
    #username = var.username
    #password = var.password
    #json_config_file = ".prismacloud_auth.json"
    json_config_file = "../.prismacloud_auth.json"

}

# resource "prismacloud_user_profile" "example" {
#     first_name = "abc"
#     last_name = "def"
#     email = "abc@email.com"
#     username = "abc@email.com"
#     role_ids = [
#         "c3364e1b-bf26-4033-9f47-2ebfab7dab11",
#     ]
#         time_zone = "America/Los_Angeles"
#         default_role_id = "c3364e1b-bf26-4033-9f47-2ebfab7dab11"
# }

locals {
    user_profiles = csvdecode(file("user_profiles.csv"))
}

// Now specify the user profile resource with a loop like this:

resource "prismacloud_user_profile" "example" {
    for_each = { for inst in local.user_profiles : inst.email => inst }

    first_name = each.value.first_name
    last_name = each.value.last_name
    email = each.value.email
    username = each.value.email
    role_ids = split("||", each.value.role_ids)
    access_keys_allowed = each.value.access_keys_allowed
    time_zone = each.value.time_zone
    default_role_id = each.value.default_role_id
}