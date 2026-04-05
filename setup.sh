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

# Configurando Flatpak e instalando PortProton
echo "Configurando Flatpak e instalando PortProton..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub ru.linux_gaming.PortProton -y

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

# 3. Copiar general.conf (Sobrescrever completo)
cp hypr/hyprland/general.conf "$HYPR_DIR/hyprland/general.conf"
echo "Arquivo general.conf aplicado em $HYPR_DIR/hyprland/general.conf"

echo "Instalação e aplicação de configurações concluídas!"
