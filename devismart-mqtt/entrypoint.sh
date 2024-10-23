#!/bin/bash

if [ -d "/config/auto-discovery-templates" ]; then
    echo "Custom templates"
    config_templates="/config/auto-discovery-templates"
else
    echo "Built in templates"
    config_templates="/app/auto-discovery-templates"
fi


exec java -cp ha-devi-mqtt.jar io.homeassistant.devi.mqtt.service.ConsoleRunner --auto-discovery-templates "$config_templates" --mqtt-config "/config/mqtt_config.json" --devi-config "/config/devi_config.json"
