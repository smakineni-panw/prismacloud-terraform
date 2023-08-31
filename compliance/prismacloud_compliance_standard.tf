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

resource "prismacloud_compliance_standard" "niranjan-test-compliance-standard" {
    name = "niranjan-test-compliance-standard"
    description = "Made by Terraform"
}

resource "prismacloud_compliance_standard_requirement" "niranjan-test-compliance-standard-requirement" {
    cs_id = prismacloud_compliance_standard.niranjan-test-compliance-standard.cs_id
    name = "niranjan-test-requirement"
    description = "Also made by Terraform"
    requirement_id = "1.007"
}

resource "prismacloud_compliance_standard_requirement_section" "example" {
    csr_id = prismacloud_compliance_standard_requirement.niranjan-test-compliance-standard-requirement.csr_id
    section_id = "Section 1"
    description = "Section description"
}