#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

# Opções
option_1="⏻ Desligar"
option_2="↻ Reiniciar"
option_3="⏾ Suspender"
option_4="← Sair"
option_5="✕ Cancelar"

# Rofi
chosen=$(echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | \
    rofi -dmenu -p "Power Menu" \
    -theme-str 'window {width: 300px;}' \
    -theme-str 'listview {lines: 5;}')

# Executar
case $chosen in
    $option_1)
        poweroff
        ;;
    $option_2)
        reboot
        ;;
    $option_3)
        systemctl suspend
        ;;
    $option_4)
        i3-msg exit
        ;;
esac
