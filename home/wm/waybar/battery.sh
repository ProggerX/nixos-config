battery="BAT0"
capacity=$(cat /sys/class/power_supply/$battery/capacity)
icons=(" " " " " " " " " ")
values=(20 40 60 80 100)
status=$(cat /sys/class/power_supply/$battery/status)
charging_symbol="󱐋"

if [ "$status" = "Charging" ]; then
	echo "$charging_symbol "
fi
for i in {0..4}; do
	if [ "$capacity" -le "${values[$i]}" ]; then
		echo "$capacity% ${icons[$i]}"
		exit
	fi
done
