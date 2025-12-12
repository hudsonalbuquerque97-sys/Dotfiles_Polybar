#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

# Verificar se PyRadio está rodando
if ! pgrep -x "pyradio" > /dev/null; then
    echo "RÁDIO: OFF"
    exit 0
fi

# Tentar pegar info via playerctl (se PyRadio suportar MPRIS)
if playerctl -l 2>/dev/null | grep -q "mpv"; then
    title=$(playerctl -p mpv metadata xesam:title 2>/dev/null)
    if [[ -n "$title" ]]; then
        if [[ ${#title} -gt 40 ]]; then
            title="${title:0:37}..."
        fi
        echo "> RÁDIO: $title"
        exit 0
    fi
fi

# Fallback: verificar processo
if ps aux | grep -v grep | grep -q "pyradio.*mplayer\|pyradio.*mpv\|pyradio.*vlc"; then
    echo "> RÁDIO: Tocando"
else
    echo " RÁDIO: Ativo"
fi
