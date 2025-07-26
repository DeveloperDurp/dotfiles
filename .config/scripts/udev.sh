#!/usr/bin/zsh

#performance() {
#
#  echo '128' >/sys/class/leds/system76_acpi::kbd_backlight/brightness
#  /usr/bin/system76-power profile performance
#}
#
#balanced() {
#
#  echo '128' >/sys/class/leds/system76_acpi::kbd_backlight/brightness
#  /usr/bin/system76-power profile balanced
#}
#
#battery() {
#
#  echo '128' >/sys/class/leds/system76_acpi::kbd_backlight/brightness
#  /usr/bin/system76-power profile battery
#}

#case "$1" in
#performance) performance ;;
#balanced) balanced ;;
#battery) battery ;;
#*) echo "Please enter an action" ;;
#esac

echo '128' >/sys/class/leds/system76_acpi::kbd_backlight/brightness
/usr/bin/system76-power profile $1
