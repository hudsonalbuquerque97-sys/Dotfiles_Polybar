#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

# Monitora o modo do i3 e imprime "RESIZE" quando em modo de redimensionamento

# Função para obter o modo atual do i3
get_i3_mode() {
    i3-msg -t get_tree | grep -oP '"mode":"\K[^"]+' | head -1
}

# Cores (formato Polybar)
NORMAL_COLOR="%{F#FFFFFF}"  # Branco para modo normal
RESIZE_COLOR="%{F#FFA500}%{u#FFA500}%{+u}"  # Laranja neon com sublinhado
RESET="%{F-}%{u-}"

# Verifica o modo inicial
MODE=$(get_i3_mode)

if [[ "$MODE" == "resize" ]]; then
    echo "${RESIZE_COLOR} RESIZE${RESET}"
else
    #echo "${NORMAL_COLOR}${RESET}"
    echo "${NORMAL_COLOR}"
fi

# Monitora mudanças no modo (opcional, para atualização em tempo real)
# Comente esta seção se quiser apenas verificação estática
while read -r line; do
    MODE=$(echo "$line" | grep -oP '"change":"\K[^"]+' | head -1)
    
    if [[ "$MODE" == "resize" ]]; then
        echo "${RESIZE_COLOR} RESIZE${RESET}"
    elif [[ "$MODE" == "default" ]]; then
        #echo "${NORMAL_COLOR}${RESET}"
        echo "${NORMAL_COLOR}"
    fi
done < <(i3-msg -t subscribe -m '[ "mode" ]')
