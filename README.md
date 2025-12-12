# 📦 Polybar Configuração Modular para i3WM

Uma configuração completa e modular do Polybar, projetada especificamente para funcionar com o i3 Window Manager.

## 🔗 Repositório

```
https://github.com/hudsonalbuquerque97-sys/Dotfiles_Polybar
```

## 📋 Requisitos

Antes de instalar esta configuração, certifique-se de ter os seguintes pacotes instalados:

### Gerenciador de Janelas e Sistema
```bash
sudo apt install i3 i3status i3lock picom dunst nitrogen network-manager-gnome
```

### Terminais e Launchers
```bash
sudo apt install kitty alacritty rofi dmenu suckless-tools
```

### Áudio e Mídia
```bash
sudo apt install pulseaudio pavucontrol playerctl mpv socat mplayer
```

### Utilitários do Sistema
```bash
sudo apt install scrot slop jq python3 python3-pip bc wmctrl brightnessctl
```

### Bluetooth
```bash
sudo apt install bluez bluez-tools
```

### Fontes
```bash
sudo apt install fonts-jetbrains-mono fonts-font-awesome
```

**Fontes Nerd Font (instalar manualmente):**
- Symbols Nerd Font Mono
- JetBrainsMono Nerd Font
- Font Awesome (versão Nerd Font)

Para instalar as Nerd Fonts, baixe de [https://www.nerdfonts.com/](https://www.nerdfonts.com/) e instale em `~/.local/share/fonts/` ou `/usr/share/fonts/`

**Instalação rápida das Nerd Fonts:**
```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# JetBrainsMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip

# Symbols Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/NerdFontsSymbolsOnly.zip
unzip NerdFontsSymbolsOnly.zip -d NerdFontsSymbols
rm NerdFontsSymbolsOnly.zip

# Atualizar cache de fontes
fc-cache -fv
```

### Temas de Ícones
```bash
sudo apt install papirus-icon-theme
```

### Aplicações Adicionais
```bash
sudo apt install geany firefox
```

### PyRadio (via pipx)
```bash
sudo apt install pipx
pipx ensurepath
pipx install pyradio
```

## 📦 Instalação

### 1. Clone o repositório
```bash
git clone https://github.com/hudsonalbuquerque97-sys/Dotfiles_Polybar.git
```

### 2. Copie os arquivos para o diretório de configuração
```bash
# Remova a configuração antiga se existir (CUIDADO: faça backup antes!)
rm -rf ~/.config/polybar

# Copie a pasta inteira para o local correto
cp -r Dotfiles_Polybar/config/polybar ~/.config/

# OU, se preferir copiar apenas o conteúdo:
mkdir -p ~/.config/polybar
cp -r Dotfiles_Polybar/config/polybar/* ~/.config/polybar/
```

### 3. Torne os scripts executáveis
```bash
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/*.sh
chmod +x ~/.config/polybar/scripts/*.py
```

### 4. Configure o i3 para iniciar o Polybar
Edite o arquivo `~/.config/i3/config`:

**a) Desabilite o i3bar (comente a linha):**
```
# bar {
#     status_command i3status
# }
```

**b) Adicione o Polybar:**
```
exec_always --no-startup-id ~/.config/polybar/launch.sh
```

> **Nota:** É importante desabilitar o i3bar para evitar conflitos com o Polybar. Comente ou remova o bloco `bar {}` do seu arquivo de configuração do i3.

### 5. Reinicie o i3
Pressione `Mod+Shift+R` ou execute:
```bash
i3-msg restart
```

## 📁 Estrutura de Arquivos

```
~/.config/polybar/
├── readme.md
├── launch.sh                    # Script de inicialização
├── config.ini                   # Arquivo principal (importa módulos)
├── modules/                     # Módulos de configuração
│   ├── colors.ini              # Cores do tema
│   ├── bar.ini                 # Configuração da barra
│   ├── i3wm.ini                # Módulos do i3WM
│   ├── media.ini               # Módulos de mídia e áudio
│   ├── system.ini              # Módulos de sistema
│   ├── network.ini             # Módulos de rede
│   └── monitoring.ini          # Monitoramento (opcional)
└── scripts/                     # Scripts auxiliares
    ├── i3-mode.py              # Indica modo mosaico ou flutuante
    ├── i3-resize-indicator.sh  # Indica modo redimensionamento
    ├── workspaces.sh           # Define as áreas de trabalho
    ├── brightness.sh           # Controle de luminosidade
    ├── powermenu.sh            # Menu de opções do sistema
    ├── bluetooth-status.sh     # Status do Bluetooth
    ├── bluetooth-toggle.sh     # Ativa/desativa Bluetooth
    ├── pyradio-*.sh            # Scripts de estações de rádio
    ├── music-mpd-style.sh      # Controle Playerctl
    ├── mpv-status.sh           # Status do MPV
    └── mpv-start.sh            # Inicialização do MPV
```

## ⚙️ Personalização

Todos os módulos estão organizados na pasta `modules/` para facilitar a personalização:

- **colors.ini** - Altere as cores do tema
- **bar.ini** - Configure a aparência da barra
- **i3wm.ini** - Ajuste os módulos específicos do i3
- **media.ini** - Configure reprodutores de mídia
- **system.ini** - Personalize informações do sistema
- **network.ini** - Ajuste módulos de rede

## 🐛 Solução de Problemas

### Polybar não inicia
```bash
# Verifique erros no arquivo de log
~/.config/polybar/launch.sh
```

### Ícones não aparecem corretamente
Certifique-se de que as Nerd Fonts estão instaladas corretamente:
```bash
fc-list | grep -i nerd
```

### Scripts não funcionam
Verifique se todos os scripts têm permissão de execução:
```bash
ls -la ~/.config/polybar/scripts/
```

## 📝 Licença

Consulte o repositório para informações sobre licença.

## 🤝 Contribuições

Contribuições são bem-vindas! Visite o repositório no GitHub para reportar problemas ou sugerir melhorias.

---

**Autor:** Hudson Albuquerque  
**Repositório:** https://github.com/hudsonalbuquerque97-sys/Dotfiles_Polybar
