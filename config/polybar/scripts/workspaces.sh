#!/bin/bash
# Áreas de trabalho fixas
# criado por hudson albuquerque hud.and@yandex.com


#icons=("" "" "" "" "" "" "" "")
icons=("" "" "" "" "" "" "" "")
#icons=("" "" "" "" "" "" "" "")
#icons=("1" "2" "3" "4" "5" "6" "7" "8")
#icons=("一" "二" "三" "四" "五" "六" "七" "八")


# Array para armazenar estados
declare -A states
for i in {1..8}; do
    states[$i]="empty"
done

# Processa workspaces ativas
while read -r line; do
    num=$(echo "$line" | jq -r '.num')
    if [ "$num" -ge 1 ] && [ "$num" -le 8 ]; then
        if echo "$line" | jq -r '.focused' | grep -q "true"; then
            states[$num]="focused"
        elif echo "$line" | jq -r '.visible' | grep -q "true"; then
            states[$num]="visible"
        elif echo "$line" | jq -r '.urgent' | grep -q "true"; then
            states[$num]="urgent"
        else
            states[$num]="occupied"
        fi
    fi
done < <(i3-msg -t get_workspaces | jq -c '.[]')

# Exibe todas as workspaces com ações de clique CORRETAS
for i in {1..8}; do
    icon="${icons[$((i-1))]}"
    
    # ABRE a ação de clique ANTES do ícone
    echo -n "%{A1:i3-msg workspace $i:}"
    
    case "${states[$i]}" in
        focused)
            echo -n "%{F#89b4fa}%{B#313244} $icon %{B-}%{F-}"
            ;;
        visible)
            echo -n "%{F#cdd6f4}%{B#45475a} $icon %{B-}%{F-}"
            ;;
        urgent)
            echo -n "%{F#1e1e2e}%{B#f38ba8} $icon %{B-}%{F-}"
            ;;
        occupied)
            echo -n "%{F#cdd6f4} $icon %{F-}"
            ;;
        empty)
            echo -n "%{F#6c7086} $icon %{F-}"
            ;;
    esac
    
    # FECHA a ação de clique DEPOIS do ícone
    echo -n "%{A}"
    
    # Adiciona UM espaço entre workspaces (opcional)
    echo -n " "
done
