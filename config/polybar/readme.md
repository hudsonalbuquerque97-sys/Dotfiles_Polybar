# 📦 Polybar Configuração Modular

## 📁 Estrutura de Diretórios

```
~/.config/polybar/
├── readme.md
├── launch.sh
├── config.ini              # Arquivo principal (importa todos os módulos)
├── modules/                # Pasta com módulos separados
│   ├── colors.ini          # Cores do tema
│   ├── bar.ini             # Configuração da barra
│   ├── i3wm.ini            # Módulos do i3WM
│   ├── media.ini           # Módulos de mídia e áudio
│   ├── system.ini          # Módulos de sistema
│   ├── network.ini         # Módulos de rede
│   └── monitoring.ini      # Monitoramento (opcional)
├── scripts/                # Scripts do i3, brightness, power menu, etc
│   ├── i3-mode.py                # Indica modo mosaico ou flutuante
│   ├── i3-resize-indicator.sh    # Indica modo redimencionamente
│   ├── workspaces.sh             # Define as áreas de trabalhos
│   ├── brightness.sh             # Luminosidade da tela
│   ├── powermenu.sh              # Opções de sistema
│   ├── bluetooth-status.sh       # Indica status do bluetooth
│   ├── bluetooth-toggle.sh       # Ativa e desativa bluetooth
│   ├── pyradio-*.sh              # Estações de radio 
│   ├── music-mpd-style.sh        # Playerctl 
│   ├── mpv-status.sh             # Indica se o MPV esta ativado
│   └── mpv-start.sh              # inicia o MPV
```




