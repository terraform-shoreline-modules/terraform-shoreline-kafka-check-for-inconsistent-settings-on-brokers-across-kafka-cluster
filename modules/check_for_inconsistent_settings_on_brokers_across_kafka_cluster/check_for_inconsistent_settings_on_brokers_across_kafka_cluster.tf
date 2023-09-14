resource "shoreline_notebook" "check_for_inconsistent_settings_on_brokers_across_kafka_cluster" {
  name       = "check_for_inconsistent_settings_on_brokers_across_kafka_cluster"
  data       = file("${path.module}/data/check_for_inconsistent_settings_on_brokers_across_kafka_cluster.json")
  depends_on = []
}

