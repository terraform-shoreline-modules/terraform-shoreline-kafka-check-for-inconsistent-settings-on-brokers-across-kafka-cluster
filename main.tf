terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "check_for_inconsistent_settings_on_brokers_across_kafka_cluster" {
  source    = "./modules/check_for_inconsistent_settings_on_brokers_across_kafka_cluster"

  providers = {
    shoreline = shoreline
  }
}