resource "shoreline_notebook" "inconsistent_kafka_broker_settings" {
  name       = "inconsistent_kafka_broker_settings"
  data       = file("${path.module}/data/inconsistent_kafka_broker_settings.json")
  depends_on = [shoreline_action.invoke_kafka_broker_config_update]
}

resource "shoreline_file" "kafka_broker_config_update" {
  name             = "kafka_broker_config_update"
  input_file       = "${path.module}/data/kafka_broker_config_update.sh"
  md5              = filemd5("${path.module}/data/kafka_broker_config_update.sh")
  description      = "Update the configuration settings for affected Kafka brokers to ensure consistency across the cluster."
  destination_path = "/tmp/kafka_broker_config_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_kafka_broker_config_update" {
  name        = "invoke_kafka_broker_config_update"
  description = "Update the configuration settings for affected Kafka brokers to ensure consistency across the cluster."
  command     = "`chmod +x /tmp/kafka_broker_config_update.sh && /tmp/kafka_broker_config_update.sh`"
  params      = ["BROKER_CONFIG_FILE","KAFKA_HOME"]
  file_deps   = ["kafka_broker_config_update"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_broker_config_update]
}

