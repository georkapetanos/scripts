#!/bin/bash
BAT=$(adb shell cat /sys/class/power_supply/battery/device/name)
LVL=$(adb shell cat /sys/class/power_supply/battery/capacity)
RAWTEMP=$(adb shell cat /sys/class/power_supply/battery/temp)
TYPE=$(adb shell cat /sys/class/power_supply/battery/technology)
TEMP=$(echo "$RAWTEMP" / 10 | tr -d $'\r' | bc)
echo "------------------------------------------"
echo "	Battery: $BAT							"
echo "------------------------------------------"
echo " Capacity: $LVL							"
echo " Temperature: $TEMP C						"
echo " Technology: $TYPE						"
echo "------------------------------------------"
