#!/bin/bash

# Atualizando sistema e instalando pacotes via pacman
echo "Instalando pacotes via pacman..."
sudo pacman -S xorg-xhost hypridle hyprlock qbittorrent telegram-desktop discord flatpak bluez-obex nwg-look vlc vlc-plugins-all --noconfirm

# Instalando pacotes do AUR via yay
echo "Instalando pacotes do AUR via yay..."
if ! command -v yay &> /dev/null
then
    echo "Yay não está instalado. Por favor, instale o yay primeiro."
    exit 1
fi

yay -S steam-devices-git brave-bin --noconfirm

# Aplicando configurações
echo "Aplicando configurações do Hyprland..."
HYPR_DIR="$HOME/.config/hypr"
mkdir -p "$HYPR_DIR/hyprland"

# 1. Copiar hypridle.conf
cp hypr/hypridle.conf "$HYPR_DIR/hypridle.conf"
echo "Arquivo hypridle.conf aplicado em $HYPR_DIR/hypridle.conf"

# 2. Copiar execs.conf
cp hypr/hyprland/execs.conf "$HYPR_DIR/hyprland/execs.conf"
echo "Arquivo execs.conf aplicado em $HYPR_DIR/hyprland/execs.conf"

# 3. Aplicar apenas o campo 'input' no general.conf
GENERAL_CONF="$HYPR_DIR/hyprland/general.conf"
REPO_GENERAL="./hypr/hyprland/general.conf"

if [ -f "$GENERAL_CONF" ]; then
    echo "Atualizando campo 'input' em $GENERAL_CONF..."
    # Usa Python para substituir o bloco 'input { ... }' com suporte a chaves aninhadas (touchpad)
    python3 -c "
import re, sys
try:
    with open('$GENERAL_CONF', 'r') as f:
        orig = f.read()
    with open('$REPO_GENERAL', 'r') as f:
        new_input = f.read()
    # Pattern que suporta um nível de chaves aninhadas (como touchpad {})
    pattern = r'input\s*\{[^{}]*(?:\{[^{}]*\}[^{}]*)*\}'
    if re.search(pattern, orig, re.DOTALL):
        res = re.sub(pattern, new_input, orig, flags=re.DOTALL)
        with open('$GENERAL_CONF', 'w') as f:
            f.write(res)
        print('Campo input atualizado com sucesso.')
    else:
        with open('$GENERAL_CONF', 'a') as f:
            f.write('\n' + new_input)
        print('Campo input não encontrado, adicionado ao final do arquivo.')
except Exception as e:
    print(f'Erro ao atualizar general.conf: {e}')
"
else:
    echo "Arquivo $GENERAL_CONF não existe. Criando novo a partir do repositório..."
    cp "$REPO_GENERAL" "$GENERAL_CONF"
fi

echo "Instalação e aplicação de configurações concluídas!"
