# Devireg Mqtt Add-on:
Based on <https://github.com/igor-podpalchenko/ha-devi-mqtt> and my fork <https://github.com/bob-tm/ha-devi-mqtt>

## How to Use 
Configure MQTT settings in addon settings. Version 0.3+ uses GUI, not mqtt_config.json.
if you have mqtt_config.json from early versions - you can delete it and copy settings to GUI. Or just leave it and Ignore GUI.

Addon needs devi_config.json to connect to Devi cloud. 
Version 0.3+ can generate it inside this addon (not tested)

## How to generate devi_config.json in 0.3 Beta +
# Method1: Inside addon, experemental 

0. Start Devismart MQTT addon. Check logs for message (devi_config.json not found. Running in waiting mode)
1. Install and Run Advanced SSH & Web Terminal https://github.com/hassio-addons/addon-ssh
2. Disable Protection mode Advanced SSH & Web Terminal
3. Click Open Web UI for Advanced SSH & Web Terminal
4. Enter in terminal `docker container ls -a | awk 'NR>1 {print $1, $2}' | grep 'devismart-mqtt'`
5. Look for CONTAINER ID for devismart-mqtt. Looks like 4b9fa34ad83e
6. Replace 4b9fa34ad83e with your id and Run  `docker exec -it 4b9fa34ad83e /config.sh`
7. Foloow instructions on screen. devi_config.json  should be saved to addon config folder.
8. Restart Devismart MQTT addon.
9. Check addon logs for message (Config Exists!) or list of autodiscovered items.
10. Go to MQTT Integration and check for Devi devices!

# Method2: needs Java to be installed on PC
0. Start Devismart MQTT addon. Check logs for message (devi_config.json not found. Running in waiting mode)
1. Open http://homeassistant:8000 and download ha-devi-mqtt.jar to your pc
2. Install Java 
3. Run java -cp ha-devi-mqtt.jar io.homeassistant.devi.mqtt.service.DiscoveryService
4. Upload devi_config.json to addon config folder "\\192.168.x.x\addon_configs\xxxxxxxx_devismart-mqtt\"
4. SRestart Devismart MQTT addon.
5. Check addon logs for message (Config Exists!) or list of autodiscovered items.
6. Go to MQTT Integration and check for Devi devices!

