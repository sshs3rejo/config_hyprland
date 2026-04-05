# Configurações do Hyprland

Repositório de configurações do meu ambiente Hyprland.

## Pré-requisitos

Para que todos os comandos (especialmente o `xhost` no `execs.conf`) funcionem, é necessário instalar os seguintes pacotes:

```bash
sudo pacman -S xorg-xhost --noconfirm
```

## Estrutura Atual

- `hyprland/general.conf`: Configurações de input, layout de teclado (br, thinkpad, abnt2) e comportamento do mouse/touchpad.
- `hyprland/execs.conf`: Configurações de inicialização e comandos automáticos.
