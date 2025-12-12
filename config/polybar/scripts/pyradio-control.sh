#!/bin/bash
# criado por Hudson Albquerque (hud.and@yandex.com)

# Verificar se PyRadio está instalado
if ! command -v pyradio &> /dev/null; then
    rofi -e "PyRadio não está instalado!\nInstale com: sudo apt install pyradio"
    exit 1
fi

# Verificar se está rodando
if pgrep -x "pyradio" > /dev/null; then
    prompt="PyRadio"
    mesg="Tocando rádio"
    
    option_1=" Abrir PyRadio"
    option_2=" Parar Rádio"
    option_3="  Volume +"
    option_4="  Volume -"
    option_5="+ Adicionar Estação"
else
    prompt="PyRadio"
    mesg="Rádio desligado"
    
    option_1=" Iniciar PyRadio"
    option_2=" Editar Estações"
    option_3=" Ver Lista"
fi

# Rofi
rofi_cmd() {
    rofi -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -theme-str 'window {width: 400px;}' \
        -theme-str 'listview {lines: 5;}'
}

# Executar rofi
run_rofi() {
    if pgrep -x "pyradio" > /dev/null; then
        echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
    else
        echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
    fi
}

# Comandos
run_cmd() {
    if pgrep -x "pyradio" > /dev/null; then
        # PyRadio está rodando
        case "$1" in
            '--open')
                # Trazer para frente ou abrir nova janela
                if command -v wmctrl &> /dev/null; then
                    wmctrl -a "PyRadio" || kitty -e pyradio &
                else
                    kitty -e pyradio &
                fi
                ;;
            '--stop')
                pkill -9 pyradio
                ;;
            '--volup')
                # Aumentar volume do sistema
                pactl set-sink-volume @DEFAULT_SINK@ +5%
                ;;
            '--voldown')
                # Diminuir volume do sistema
                pactl set-sink-volume @DEFAULT_SINK@ -5%
                ;;
            '--add')
                # Abrir editor de estações
                kitty -e pyradio -a &
                ;;
        esac
    else
        # PyRadio não está rodando
        case "$1" in
            '--start')
                kitty -e pyradio &
                ;;
            '--edit')
                kitty -e nano ~/.config/pyradio/stations.csv &
                ;;
            '--list')
                if [[ -f ~/.config/pyradio/stations.csv ]]; then
                    cat ~/.config/pyradio/stations.csv | rofi -dmenu -p "Estações Salvas"
                else
                    rofi -e "Nenhuma estação salva ainda"
                fi
                ;;
        esac
    fi
}

# Processar escolha
chosen="$(run_rofi)"

if pgrep -x "pyradio" > /dev/null; then
    case ${chosen} in
        $option_1)
            run_cmd --open
            ;;
        $option_2)
            run_cmd --stop
            ;;
        $option_3)
            run_cmd --volup
            ;;
        $option_4)
            run_cmd --voldown
            ;;
        $option_5)
            run_cmd --add
            ;;
    esac
else
    case ${chosen} in
        $option_1)
            run_cmd --start
            ;;
        $option_2)
            run_cmd --edit
            ;;
        $option_3)
            run_cmd --list
            ;;
    esac
fi
