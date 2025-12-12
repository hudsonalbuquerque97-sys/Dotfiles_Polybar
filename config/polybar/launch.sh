#!/bin/bash

# Terminar instâncias em execução
killall -q polybar

# Aguardar até que os processos sejam encerrados
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Iniciar Polybar
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar iniciada..."
