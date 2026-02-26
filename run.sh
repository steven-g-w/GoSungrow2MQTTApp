#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

export MQTT_BROKER=$(jq -r '.mqtt_broker' $CONFIG_PATH)
export MQTT_USERNAME=$(jq -r '.mqtt_username' $CONFIG_PATH)
export MQTT_PASSWORD=$(jq -r '.mqtt_password' $CONFIG_PATH)
export MQTT_TOPIC=$(jq -r '.mqtt_topic' $CONFIG_PATH)
export PS_ID=$(jq -r '.ps_id' $CONFIG_PATH)

cd /app

node index.js