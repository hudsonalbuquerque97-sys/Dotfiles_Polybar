#!/bin/bash
# ~/.config/polybar/music-mpd-style.sh
# Botões visíveis + texto com scroll (estilo MPD)
# criado por Hudson Albquerque (hud.and@yandex.com)

SCROLL_FILE="/tmp/polybar_music_scroll"
MAX_LENGTH=35
SCROLL_SPEED=3

# Cores Catppuccin
BASE_COLOR="#1e1e2e"
TEXT_COLOR="#cdd6f4"
BTN_COLOR="#89b4fa"
PLAY_COLOR="#a6e3a1"
PAUSE_COLOR="#f9e2af"
DISABLED_COLOR="#6c7086"

# Verificar se há player
if ! playerctl -l 2>/dev/null | grep -q .; then
    echo "%{F$DISABLED_COLOR}󰽰%{F-} Sem música"
    exit 0
fi
#ICONES OPÇÔES  ♫  ♪  󰽰

# Pegar status
status=$(playerctl status 2>/dev/null)

# Criar botões
case "$status" in
    "Playing")
        play_icon="%{F$PAUSE_COLOR}󰏤%{F-}"
        ;;
    "Paused")
        play_icon="%{F$PLAY_COLOR}󰐊%{F-}"
        ;;
    *)
        play_icon="%{F$DISABLED_COLOR}󰓛%{F-}"
        ;;
esac
#ICONES OPÇÔES    ▶    󰏤    󰓛

# Botões com ações de clique
prev_btn="%{A1:playerctl previous:}%{F$BTN_COLOR}󰒮%{F-}%{A}"
next_btn="%{A1:playerctl next:}%{F$BTN_COLOR}󰒭%{F-}%{A}"
play_btn="%{A1:playerctl play-pause:}$play_icon%{A}"

# Se não está tocando nem pausado, mostrar apenas botões
if [[ "$status" != "Playing" ]] && [[ "$status" != "Paused" ]]; then
    echo "$prev_btn $play_btn $next_btn %{F$DISABLED_COLOR}Parado%{F-}"
    exit 0
fi

# Pegar informações da música
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

[[ -z "$title" ]] && title=$(playerctl metadata xesam:title 2>/dev/null || echo "Tocando...")

# Montar texto completo
if [[ -n "$artist" ]]; then
    full_text="$artist - $title"
else
    full_text="$title"
fi

# Sistema de scroll para textos longos
if [[ ${#full_text} -le $MAX_LENGTH ]]; then
    text_display="$full_text"
    rm -f "$SCROLL_FILE" 2>/dev/null
else
    # Inicializar ou ler posição do scroll
    if [[ -f "$SCROLL_FILE" ]]; then
        scroll_pos=$(cat "$SCROLL_FILE")
    else
        scroll_pos=0
    fi
    
    # Mover posição
    if [[ $((scroll_pos % SCROLL_SPEED)) -eq 0 ]]; then
        pos=$((scroll_pos / SCROLL_SPEED))
    else
        pos=$((scroll_pos / SCROLL_SPEED))
    fi
    
    # Texto estendido para looping
    scroll_text="  $full_text    "
    text_len=${#scroll_text}
    pos=$((pos % text_len))
    
    # Extrair parte visível
    display="${scroll_text:$pos:$MAX_LENGTH}"
    
    # Completar se necessário
    if [[ ${#display} -lt $MAX_LENGTH ]]; then
        remaining=$((MAX_LENGTH - ${#display}))
        display="${display}${scroll_text:0:$remaining}"
    fi
    
    text_display="$display"
    
    # Salvar nova posição
    echo $((scroll_pos + 1)) > "$SCROLL_FILE"
fi

# Saída final: botões + texto
echo "$prev_btn $play_btn $next_btn %{F$TEXT_COLOR}$text_display%{F-}"
