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

module "inconsistent_kafka_broker_settings" {
  source    = "./modules/inconsistent_kafka_broker_settings"

  providers = {
    shoreline = shoreline
  }
}