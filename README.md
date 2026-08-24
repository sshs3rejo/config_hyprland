# Configurações do Hyprland

Personalizações do meu ambiente [dots-hyprland](https://github.com/end-4/dots-hyprland).

O conteúdo deste repositório **é** o diretório `~/.config/hypr/custom`: a base (`~/.config/hypr/hyprland/`) é gerenciada pelo dots-hyprland e não deve ser versionada aqui, pois é sobrescrita a cada atualização do upstream. Os arquivos em `custom/` são carregados depois da base e nunca são sobrescritos — o serviço `create_custom_config.lua` só cria os templates que estiverem ausentes.

## Pré-requisitos

1. Instalar o [dots-hyprland](https://github.com/end-4/dots-hyprland) primeiro (ele fornece a base em `~/.config/hypr/hyprland/`).
2. Pacotes:

```bash
# Pacotes do sistema (Pacman)
sudo pacman -S xorg-xhost hypridle hyprlock qbittorrent telegram-desktop discord flatpak bluez-obex nwg-look vlc vlc-plugins-all scrcpy --noconfirm

# Pacotes do AUR (Yay)
yay -S steam-devices-git brave-bin antigravity ventoy-bin onlyoffice-bin --noconfirm

# Flatpak (PortProton)
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub ru.linux_gaming.PortProton -y
```

> O `xorg-xhost` é necessário porque a base (`hyprland/execs.lua`) roda `xhost +local:root` no startup.

## Aplicação

```bash
cd ~/.config/hypr
rm -rf custom
git clone https://github.com/sshs3rejo/config_hyprland.git custom
cp -i custom/hypridle.conf hypridle.conf
```

O `rm` é preciso porque o dots-hyprland já cria templates em `custom/` no primeiro boot. O `hypridle.conf` não tem mecanismo de override, por isso é copiado manualmente após o clone (mantém os timeouts personalizados de bloqueio/tela/suspensão).

## Estrutura

| Arquivo         | Propósito                                                                   |
| --------------- | --------------------------------------------------------------------------- |
| `general.lua`   | Input: teclado br/thinkpad/abnt2, mouse e touchpad                          |
| `keybinds.lua`  | Keybinds próprios (inclui `CTRL+SUPER+ALT+/` para editar este arquivo)      |
| `execs.lua`     | Comandos de inicialização adicionais (o `xhost +local:root` já vem da base) |
| `env.lua`       | Variáveis de ambiente                                                       |
| `rules.lua`     | Regras de janela                                                            |
| `variables.lua` | Variáveis do Hyprland                                                       |
| `hypridle.conf` | Idle/energia (lock 29 min, dpms off 30 min, suspend 40 min)                 |

Para sincronizar o tema do SDDM com o wallpaper atual, a máquina local mantém `~/.config/hypr/custom/scripts/sync-sddm-theme.sh` (não versionado).
