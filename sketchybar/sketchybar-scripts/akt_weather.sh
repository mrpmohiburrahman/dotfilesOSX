#!/bin/bash

# Aktuelles Datum bestimmen
current_date=$(date -u +"%Y-%m-%d")

# Wetterdaten von der API abrufen
weather_data=$(curl -s "https://api.brightsky.dev/weather?lat=23.8041&lon=90.4152&date=${current_date}")

# Aktuelle Zeit in UTC bestimmen
current_time=$(date -u +"%Y-%m-%dT%H:%M:%S%z")
current_minute=$(date -u +"%M")

# Berechne die richtige volle Stunde basierend auf der aktuellen Minute
if [ "$current_minute" -le 30 ]; then
    correct_hour=$(date -u +"%Y-%m-%dT%H:00:00+00:00")
else
    correct_hour=$(date -u -r $(($(date -u +%s) + 3600)) +"%Y-%m-%dT%H:00:00+00:00")
fi

# Data extraction
temperature=$(echo "$weather_data" | jq -r --arg correct_hour "$correct_hour" '
    .weather[] | select(.timestamp == $correct_hour) | .temperature')
icon=$(echo "$weather_data" | jq -r --arg correct_hour "$correct_hour" '
    .weather[] | select(.timestamp == $correct_hour) | .icon')
condition=$(echo "$weather_data" | jq -r --arg correct_hour "$correct_hour" '
    .weather[] | select(.timestamp == $correct_hour) | .condition')
wind_speed=$(echo "$weather_data" | jq -r --arg correct_hour "$correct_hour" '
    .weather[] | select(.timestamp == $correct_hour) | .wind_speed')
cloud_cover=$(echo "$weather_data" | jq -r --arg correct_hour "$correct_hour" '
    .weather[] | select(.timestamp == $correct_hour) | .cloud_cover')
visibility=$(echo "$weather_data" | jq -r --arg correct_hour "$correct_hour" '
    .weather[] | select(.timestamp == $correct_hour) | .visibility')

# Ergebnisse auf separaten Zeilen ausgeben
echo "Station Name: Dhaka, Bangladesh"
echo "Condition: ${condition}"
echo "Icon: ${icon}"
echo "Temperature: ${temperature}°C"
echo "Wind Speed: ${wind_speed}"
echo "Cloud Cover: ${cloud_cover}"
echo "Visibility: ${visibility}"
