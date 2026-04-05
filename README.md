# Configurações do Hyprland

Repositório de configurações do meu ambiente Hyprland.

## Pré-requisitos

```bash
# Pacotes do sistema (Pacman)
sudo pacman -S xorg-xhost hypridle hyprlock qbittorrent telegram-desktop discord flatpak bluez-obex nwg-look vlc vlc-plugins-all --noconfirm

# Pacotes do AUR (Yay)
yay -S steam-devices-git brave-bin --noconfirm
# Ou execute o script de instalação automática:
chmod +x setup.sh && ./setup.sh
```

## Estrutura Atual

- `hypr/hyprland/general.conf`: Configurações de input, layout de teclado (br, thinkpad, abnt2) e comportamento do mouse/touchpad.
- `hypr/hyprland/execs.conf`: Configurações de inicialização e comandos automáticos.
- `hypr/hypridle.conf`: Configurações de gerenciamento de energia e bloqueio de tela (idle).
