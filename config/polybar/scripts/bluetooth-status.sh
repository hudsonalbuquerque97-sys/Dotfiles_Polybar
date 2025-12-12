#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

if systemctl is-active --quiet bluetooth.service; then
    connected=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
    
    if [[ "$connected" -gt 0 ]]; then
        echo "● BT ON ($connected)"
    else
        echo "● BT ON"
    fi
else
    echo "○ BT OFF"
fi

#if systemctl is-active --quiet bluetooth.service; then
#    connected=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
    
#    if [[ "$connected" -gt 0 ]]; then
#        echo "BT ON ($connected)"
#    else
#        echo "BT ON"
#    fi
#else
#    echo "BT OFF"
#fi
