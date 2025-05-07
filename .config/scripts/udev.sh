#!/usr/bin/zsh

performance() {

  echo '128' >/sys/class/leds/system76_acpi::kbd_backlight/brightness
  /usr/bin/system76-power profile performance
}

battery() {

  echo '128' >/sys/class/leds/system76_acpi::kbd_backlight/brightness
  /usr/bin/system76-power profile battery
}

case "$1" in
performance) performance ;;
battery) battery ;;
*) echo "Please enter an action" ;;
esac
