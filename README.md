# Configurações do Hyprland

Personalizações do meu ambiente [dots-hyprland](https://github.com/end-4/dots-hyprland).

O conteúdo deste repositório **é** o diretório `~/.config/hypr/custom`: a base (`~/.config/hypr/hyprland/`) é gerenciada pelo dots-hyprland e não deve ser versionada aqui, pois é sobrescrita a cada atualização do upstream. Os arquivos em `custom/` são carregados depois da base e nunca são sobrescritos — o serviço `create_custom_config.lua` só cria os templates que estiverem ausentes.

## Pré-requisitos

1. Instalar o [dots-hyprland](https://github.com/end-4/dots-hyprland) primeiro (ele fornece a base em `~/.config/hypr/hyprland/`).
2. Pacotes:

```bash
# Pacotes do sistema (Pacman)

# Utilitários de arquivo
sudo pacman -S --needed --noconfirm less 7zip unrar zip unzip ark discover

# Terminal, rede e monitoramento
sudo pacman -S --needed --noconfirm neovim btop fastfetch viu lsof nmap openbsd-netcat proxychains-ng speedtest-cli usbutils tailscale fwupd github-cli

# Desenvolvimento
sudo pacman -S --needed --noconfirm docker docker-compose nodejs npm pnpm mysql-workbench

# Aplicativos e desktop
sudo pacman -S --needed --noconfirm xorg-xhost hypridle hyprlock qbittorrent telegram-desktop discord flatpak bluez-obex nwg-look vlc vlc-plugins-all scrcpy kdenlive kamoso foliate zenity

# Pacotes do AUR (Yay)
yay -S --needed --noconfirm steam-devices-git zen-browser-bin ventoy-bin onlyoffice-bin visual-studio-code-bin pgadmin4-bin anydesk-bin localsend-bin upscayl-ncnn z-library-bin sunshine-bin wifi-qr timeshift-autosnap gnome-network-displays portproton
```

> O `xorg-xhost` é necessário para o `xhost +local:root` executado no startup.

## Aplicação

```bash
cd ~/.config/hypr
rm -rf custom
git clone https://github.com/sshs3rejo/config_hyprland.git custom
cp -i custom/hypridle.conf hypridle.conf
```

O `rm` é preciso porque o dots-hyprland já cria templates em `custom/` no primeiro boot. O `hypridle.conf` não tem mecanismo de override, por isso é copiado manualmente após o clone (mantém os timeouts personalizados de bloqueio/tela/suspensão).

Depois do clone, defina o layout do teclado em **Configurações → Hyprland → Input → Keyboard** (`br`). O end4-pC grava o layout em `~/.config/hypr/hyprland/shellOverrides/main.lua`, que carrega depois de `custom/` e por isso tem precedência. O `custom/general.lua` mantém apenas `kb_variant = thinkpad` e `kb_model = abnt2`, que a GUI não cobre (modelo) ou não persiste sem edição manual (variante).

## Estrutura

| Arquivo         | Propósito                                                                   |
| --------------- | --------------------------------------------------------------------------- |
| `general.lua`   | Input: variante/modelo do teclado (`thinkpad`/`abnt2`), mouse e touchpad     |
| `keybinds.lua`  | Keybinds próprios (`CTRL+SUPER+ALT+/` edita o arquivo; `SUPER+Esc` abre as configurações) |
| `execs.lua` | Comandos de inicialização (`xhost +local:root` p/ apps GTK/XWayland) |
| `env.lua`       | Variáveis de ambiente                                                       |
| `rules.lua`     | Regras de janela                                                            |
| `variables.lua` | Variáveis do Hyprland                                                       |
| `hypridle.conf` | Idle/energia (lock 29 min, dpms off 30 min, suspend 40 min)                 |
