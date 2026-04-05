# Configurações do Hyprland

Repositório de configurações do meu ambiente Hyprland.

## Pré-requisitos

Para que todos os comandos (especialmente o `xhost` no `execs.conf`) funcionem, é necessário instalar os seguintes pacotes:

```bash
sudo pacman -S xorg-xhost hypridle hyprlock --noconfirm
```

## Estrutura Atual

- `hypr/hyprland/general.conf`: Configurações de input, layout de teclado (br, thinkpad, abnt2) e comportamento do mouse/touchpad.
- `hypr/hyprland/execs.conf`: Configurações de inicialização e comandos automáticos.
- `hypr/hypridle.conf`: Configurações de gerenciamento de energia e bloqueio de tela (idle).
