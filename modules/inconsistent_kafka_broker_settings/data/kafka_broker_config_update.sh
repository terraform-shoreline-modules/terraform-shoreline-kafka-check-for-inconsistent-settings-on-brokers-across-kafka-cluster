bash

#!/bin/bash



# Set variables for Kafka cluster configuration

KAFKA_HOME=${PATH_TO_KAFKA_HOME_DIRECTORY}

BROKER_CONFIG_FILE=${PATH_TO_KAFKA_BROKER_CONFIGURATION_FILE}



# Loop through the list of Kafka brokers

for BROKER in ${LIST_OF_AFFECTED_KAFKA_BROKER_IDS}

do

  # Update the broker configuration to match the rest of the cluster

  sed -i 's/${INCONSISTENT_SETTING}/${CONSISTENT_SETTING}/g' $KAFKA_HOME/config/$BROKER_CONFIG_FILE

done