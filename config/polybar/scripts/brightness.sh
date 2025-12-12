#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

# Pega o brilho atual
current=$(xrandr --verbose | grep -i brightness | head -1 | cut -f2 -d " ")

# Se não conseguir pegar, assume 1.0
if [ -z "$current" ]; then
    current=1.0
fi

# Converte para porcentagem
percentage=$(echo "$current * 100" | bc | cut -d'.' -f1)

# Define o ícone baseado no nível de brilho
if [ $percentage -ge 90 ]; then
    icon="󰃡 "  # Brilho máximo
elif [ $percentage -ge 70 ]; then
    icon="󰃠 "  # Brilho alto
elif [ $percentage -ge 50 ]; then
    icon="󰃟 "  # Brilho médio
elif [ $percentage -ge 30 ]; then
    icon="󰃞 "  # Brilho baixo
else
    icon="󰃞 "  # Brilho mínimo
fi

# Exibe o ícone com a porcentagem
echo "$icon $percentage%"

