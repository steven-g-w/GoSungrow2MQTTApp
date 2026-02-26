#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json
ENV_FILE=/app/.env
SUN_DIR=/app/gosungrow
SUN_CONFIG=$SUN_DIR/config.json

echo "Reading Home Assistant options..."

# 确保 jq 存在
if ! command -v jq &> /dev/null; then
  apk add --no-cache jq
fi

#######################################
# 1️⃣ 生成 .env 文件
#######################################

cat <<EOF > $ENV_FILE
MQTT_BROKER=$(jq -r '.mqtt_broker' $CONFIG_PATH)
MQTT_USERNAME=$(jq -r '.mqtt_username' $CONFIG_PATH)
MQTT_PASSWORD=$(jq -r '.mqtt_password' $CONFIG_PATH)
MQTT_TOPIC=$(jq -r '.mqtt_topic' $CONFIG_PATH)
PS_ID=$(jq -r '.ps_id' $CONFIG_PATH)
EOF

echo ".env generated"

#######################################
# 2️⃣ 生成 gosungrow/config.json
#######################################

mkdir -p $SUN_DIR

cat <<EOF > $SUN_CONFIG
{
  "host": "$(jq -r '.sungrow_host' $CONFIG_PATH)",
  "appkey": "$(jq -r '.sungrow_appkey' $CONFIG_PATH)",
  "user": "$(jq -r '.sungrow_user' $CONFIG_PATH)",
  "password": "$(jq -r '.sungrow_password' $CONFIG_PATH)",
  "config": "/root/.GoSungrow/config.json",
  "debug": false,
  "help": false,
  "quiet": false,
  "save": false,
  "timeout": "30s"
}
EOF

echo "gosungrow config.json generated"

#######################################
# 3️⃣ 启动应用
#######################################

cd /app
exec node index.js