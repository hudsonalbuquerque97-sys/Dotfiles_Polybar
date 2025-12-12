#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

# Toggle bluetooth service
if systemctl is-active --quiet bluetooth.service; then
    # Está ligado, vamos desligar
    bluetoothctl power off
    notify-send "Bluetooth" "○ Desligado" -t 2000
else
    # Está desligado, vamos ligar
    bluetoothctl power on
    notify-send "Bluetooth" "● Ligado" -t 2000
fi
