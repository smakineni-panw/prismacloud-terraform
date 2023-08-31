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

resource "prismacloud_policy" "Rehan-test-policy" {
    name = "Rehan-test-policy"
    policy_type = "config"
    severity = "low"
    cloud_type = "gcp"
    description = "test policy"
    compliance_metadata {
      compliance_id = "test"
     }
 
    rule {
        name = "my rule"
        criteria = "xxxxxx"
        parameters = {
            "savedSearch": "true",
            "withIac": "false",
        }
        rule_type = "Config"
    }

}