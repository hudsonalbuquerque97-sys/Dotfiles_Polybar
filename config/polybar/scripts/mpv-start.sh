#!/bin/bash
# ~/.config/polybar/mpv-start.sh
# criado por Hudson Albquerque (hud.and@yandex.com)

# Verifica se MPV já está rodando
if pgrep -x "mpv" > /dev/null; then
    # Se já está rodando, para
    pkill mpv
    echo "▶"  # Mostra ícone PLAY
else
    # Inicia MPV em background
    nohup mpv --no-video --shuffle ~/Músicas/ > /dev/null 2>&1 &
    echo ""  # Mostra ícone STOP
fi

#ICONES OPÇÔES   ▶    󰏤    󰓛
