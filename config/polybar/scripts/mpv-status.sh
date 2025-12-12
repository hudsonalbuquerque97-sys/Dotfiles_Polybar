#!/bin/bash
# ~/.config/polybar/mpv-status.sh
# criado por Hudson Albquerque (hud.and@yandex.com)

if pgrep -x "mpv" > /dev/null; then
    # MPV está rodando - mostra botão STOP vermelho
    echo "%{F#f38ba8}%{F-}"  # Vermelho Catppuccin
else
    # MPV parado - mostra botão PLAY verde
    echo "%{F#a6e3a1}▶%{F-}"  # Verde Catppuccin
fi

#ICONES OPÇÔES   ▶    󰏤    󰓛
