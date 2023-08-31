# Manage a RQL search on the Prisma Cloud Platform. This TF will create a RQL query in "My Recent Searches" under "Investigate"
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


resource "prismacloud_saved_search" "example" {
    name = "Made by Terraform"
    description = "made by terraform"
    search_id = prismacloud_rql_search.x.search_id
    query = prismacloud_rql_search.x.query
    time_range {
        relative {
            unit = prismacloud_rql_search.x.time_range.0.relative.0.unit
            amount = prismacloud_rql_search.x.time_range.0.relative.0.amount
        }
    }
}

resource "prismacloud_rql_search" "x" {
    search_type = "config"
    skip_result = true
    query = "config from cloud.resource where api.name = 'aws-ec2-describe-instances'"
    time_range {
        relative {
            unit = "hour"
            amount = 24
        }
    }
}
