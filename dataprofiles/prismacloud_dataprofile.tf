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

resource "prismacloud_dataprofile" "example" {
    name = "test_dataprofile"
    description = "Made by Terraform"
    data_patterns_rule_1 {
        data_pattern_rules {
            name = "Data pattern name"
            confidence_level = "low"
            match_type = "include"
            occurrence_operator_type = "less_than_equal_to"
            occurrence_count = 5
        }
    }
}