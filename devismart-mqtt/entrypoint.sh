#!/bin/bash

if [ ! -d "/config/auto-discovery-templates" ]; then
    echo "Copy Config"
    cp -av "/app/auto-discovery-templates" "/config/auto-discovery-templates"
fi

exec java -cp ha-devi-mqtt.jar io.homeassistant.devi.mqtt.service.ConsoleRunner --auto-discovery-templates "/config/auto-discovery-templates" --mqtt-config "/config/mqtt_config.json" --devi-config "/config/devi_config.json"