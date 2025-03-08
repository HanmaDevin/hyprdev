#!/usr/bin/env bash

while true; do
	BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)
	capacity="$(cat /sys/class/power_supply/${BAT}/capacity)"
	BATSTATUS="$(cat /sys/class/power_supply/${BAT}/status)"

	if [ "$BATSTATUS" == "Discharging" ]; then
		if [ "$capacity" -le 20 ]; then
		  notify-send "Battery Warning!" "Battery is at ${capacity}%"
		  sleep 1800 
		fi
	fi
done
