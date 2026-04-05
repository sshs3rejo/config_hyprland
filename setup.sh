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

echo "Instalação de pacotes concluída!"
echo "As configurações do Hyprland devem ser aplicadas manualmente conforme necessário."
