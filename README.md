
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Check for inconsistent settings on brokers across Kafka cluster
---

This incident type refers to the occurrence of inconsistent settings across the brokers in a Kafka cluster. A Kafka cluster is a group of servers that work together to process and store data streams. Each server in a Kafka cluster is called a broker. Inconsistent settings can cause issues with data processing, storage, and retrieval, leading to potential data loss or corruption. This incident requires a thorough investigation of the settings on each broker to identify any discrepancies and ensure that all settings are consistent across the cluster.

### Parameters
```shell
export 1_N="PLACEHOLDER"

export PROPERTY="PLACEHOLDER"

export _SSH_BROKER2="PLACEHOLDER"

export _SSH_BROKER1="PLACEHOLDER"

export BROKER1="PLACEHOLDER"

export BROKER2="PLACEHOLDER"

export ZOOKEEPER_HOST="PLACEHOLDER"

export TOPIC_NAME="PLACEHOLDER"

export GROUP_ID="PLACEHOLDER"

export BROKER1_9092_BROKER2_9092="PLACEHOLDER"

export BOOTSTRAP_SERVER="PLACEHOLDER"
```

## Debug

### Check if all brokers are running
```shell
systemctl status kafka-broker-${1_N}
```

### Check broker configuration
```shell
cat /etc/kafka/server.properties | grep -i ${PROPERTY}
```

### Check broker logs for errors
```shell
journalctl -u kafka-broker-${1_N} | grep -i error
```

### Check broker resource utilization
```shell
top | grep -i kafka-broker-${1_N}
```

### Check consistency of broker settings
```shell
diff ${_SSH_BROKER1} "cat /etc/kafka/server.properties") ${_SSH_BROKER2} "cat /etc/kafka/server.properties")
```

### Check network connectivity between brokers
```shell
ping ${BROKER1} ${BROKER2}
```

### Check leader election status
```shell
kafka-topics --describe --zookeeper ${ZOOKEEPER_HOST} --topic ${TOPIC_NAME}
```

### Check if replicas are in sync
```shell
kafka-replica-verification --broker-list ${BROKER1_9092_BROKER2_9092} --topic ${TOPIC_NAME} --group-id ${GROUP_ID}
```

### Check if there are any unclean leader elections
```shell
kafka-consumer-groups --bootstrap-server ${BOOTSTRAP_SERVER} --describe --group ${GROUP_ID}
```