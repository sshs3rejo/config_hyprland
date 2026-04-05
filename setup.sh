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

echo "Instalação concluída!"
