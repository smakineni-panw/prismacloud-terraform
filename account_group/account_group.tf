#provider requirements https://developer.hashicorp.com/terraform/language/providers/requirements 
terraform {
  required_providers {
    prismacloud = {
      source = "PaloAltoNetworks/prismacloud"
      version = "1.4.5"
    }
  }
}
# provider configuration https://developer.hashicorp.com/terraform/language/providers/configuration 
provider "prismacloud" {
    #url = var.url
    #username = var.username
    #password = var.password
    #json_config_file = ".prismacloud_auth.json"
    json_config_file = "../.prismacloud_auth.json"

}

 locals {
     account_groups = csvdecode(file("acc_grps.csv"))
 }

# // Now specify the account group resource with a loop like this:
 resource "prismacloud_account_group" "example" {
         for_each = { for inst in local.account_groups : inst.name => inst }

        name = each.value.name
        account_ids = split("||", each.value.accountIDs)
        description = each.value.description
}

# resource "prismacloud_account_group" "niranjan-test-accountgroup" {
#     name = "niranjan-test-accountgroup2"
#     description = "Made by Terraform using json file"
#    account_ids = [ 212193468572 ]
# }
