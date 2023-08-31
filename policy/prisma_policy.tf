
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

# resource "prismacloud_compliance_standard" "CS_PANW" {
#     name = "PANW-terraform-234"
#     description = "Compliance Standards PANW"
# }

# resource "prismacloud_compliance_standard_requirement" "CSR_PANW_TEAM1" {
#     cs_id = prismacloud_compliance_standard.CS_PANW.cs_id
#     name = "PANW - Building Blocks"
#     description = "PANW Building Blocks"
#     requirement_id = "PANW Building Blocks"
# }

# resource "prismacloud_compliance_standard_requirement_section" "CSRS_PANW_TEAM1_EC2" {
#     csr_id = prismacloud_compliance_standard_requirement.CSR_PANW_TEAM1.csr_id
#     section_id = "EC2"
#     description = "Requirement Section for EC2"
# }

resource "prismacloud_rql_search" "x" {
    search_type = "config"
    query = "config from cloud.resource where api.name = 'aws-ec2-key-pair' AND json.rule = keyName exists"
    time_range {
        relative {
            unit = "hour"
            amount = 24
        }
    }
}

resource "prismacloud_saved_search" "example" {
    name = var.policy_name
    description = var.description
    search_id = prismacloud_rql_search.x.search_id
    query = prismacloud_rql_search.x.query
    time_range {
        relative {
            unit = prismacloud_rql_search.x.time_range.0.relative.0.unit
            amount = prismacloud_rql_search.x.time_range.0.relative.0.amount
        }
    }
}


resource "prismacloud_policy" "this" {
    name                        = var.policy_name
    policy_type                 = var.policy_type
    description                 = var.description
    recommendation              = var.remediation
    restrict_alert_dismissal    = var.restrict_alert_dismissal
    enabled                     = var.enabled
    severity                    = var.policy_severity
    cloud_type                  = var.policy_cloud
    rule {
        name        = var.policy_name
        criteria    = prismacloud_saved_search.example.search_id
        rule_type   = var.rule_type
        parameters  = {
            "savedSearch": true,
            "withIac": false,
        }
    }
    compliance_metadata {
        #compliance_id     = prismacloud_compliance_standard_requirement_section.CSRS_PANW_TEAM1_EC2.csrs_id
        compliance_id = "4256dc5e-8c25-4ac9-8da7-487f0dae2652"
        #custom_assigned = true
    #   requirement_id = prismacloud_compliance_standard_requirement.CSR_PANW_TEAM1.requirement_id
    #   requirement_name = prismacloud_compliance_standard_requirement.CSR_PANW_TEAM1.name
    #   section_id = prismacloud_compliance_standard_requirement_section.CSRS_PANW_TEAM1_EC2.section_id
    #   standard_name = prismacloud_compliance_standard.CS_PANW.name
    #   section_description = prismacloud_compliance_standard_requirement_section.CSRS_PANW_TEAM1_EC2.description
    #   standard_description = prismacloud_compliance_standard.CS_PANW.description
    #   #only mandatory parameter is compliance_id which corresponds to the section ID (not requirement and not compliance. section ID will identify those 2 automatically).
    }
}




