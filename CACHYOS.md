# Migração para CachyOS

Guia curto para reinstalar o desktop num CachyOS (Arch) mantendo o end-4 e as
customizações deste repo. O kit de restauração complementa este documento.

## O que muda

| Função | Arch atual | CachyOS novo |
|---|---|---|
| Kernel | `linux-zen` | `linux-cachyos` |
| Bootloader | `grub` + `grub-btrfs` | `limine` + `limine-mkinitcpio-hook` |
| Snapshots | `timeshift` + `timeshift-autosnap` | `snapper` + `snap-pac` + `btrfs-assistant` + `limine-snapper-sync` |
| Home nos snapshots | Timeshift incluía `@home` | Snapper só root por padrão; criar config `home` |

O `restore.sh` do kit filtra `linux-zen`, `grub`, `grub-btrfs`, `timeshift` e
`timeshift-autosnap` para não conflitar com a base do CachyOS.

## Partição (opção A: diskpart + Windows primeiro)

No instalador do Windows 10, `Shift+F10`:

```
diskpart
list disk
select disk 0
clean
convert gpt
create partition efi size=4096
format quick fs=fat32 label="ESP"
create partition msr size=16
exit
```

Instale o Windows no espaço não alocado. Depois, com BitLocker e Fast Startup
desligados (`powercfg /h off`), reduza o `C:` para ~140 GiB no Gerenciamento de
Disco. No Calamares, monte a ESP de 4 GiB em `/boot` **sem formatar** e crie o
btrfs no espaço livre. Bootloader: Limine.

## Snapper: incluir a home

O instalador do CachyOS configura o Snapper só para `@`. A home (`@home`) fica
fora de propósito: voltar o sistema não deve desfazer arquivos salvos depois do
snapshot. Para ter snapshots da home como o Timeshift tinha:

```bash
sudo snapper -c home create-config /home
sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer
sudo snapper -c home list
sudo snapper -c home create --description "manual"
```

- `btrfs-assistant` gerencia root e home, inclusive restauração de arquivos.
- `limine-snapper-sync` cria entradas de boot só para root; snapshots da home
  são restaurados pelo Btrfs Assistant/Snapper.
- `snap-pac` faz pré/pós-pacman só no root; a home usa a timeline diária.
- Retenção sugerida (parecida com os 3 do Timeshift):
  ```bash
  sudo snapper -c home set-config TIMELINE_LIMIT_DAILY=7
  sudo snapper -c home set-config TIMELINE_LIMIT_WEEKLY=4
  sudo snapper -c home set-config TIMELINE_LIMIT_MONTHLY=3
  ```

## Apps que precisam voltar

Além dos `illogical-impulse-*` e do end-4:

- **Dev/IA**: `opencode`, `visual-studio-code-bin`, `antigravity`, `zed`,
  `neovim`, `docker`, `docker-compose`, `nodejs`, `npm`, `pnpm`, `jdk25-openjdk`,
  `fvm`, `godot`, `blender`, `github-cli`, `premake`.
- **Bancos**: `dbeaver`, `pgadmin4-bin`, `mysql-workbench`.
- **Navegador/comunicação**: `zen-browser-bin`, `telegram-desktop`, `discord`,
  `onlyoffice-bin`, `foliate`, `z-library-bin`.
- **Rede/terminal**: `btop`, `htop`, `fastfetch`, `aria2`, `rclone`, `tailscale`,
  `nmap`, `proxychains-ng`, `openbsd-netcat`, `speedtest-cli`, `wifi-qr`.
- **Celular/mídia/jogos**: `scrcpy`, `gnirehtet-bin`, `localsend-bin`,
  `anydesk-bin`, `sunshine-bin`, `vlc`, `kdenlive`, `kamoso`, `upscayl-ncnn`,
  `qbittorrent`, `portproton`, `steam-devices-git`, `ventoy-bin`.
- **T480**: `python-validity`, `open-fprintd`, `fprintd-clients-git`, `fwupd`,
  `power-profiles-daemon`, `intel-media-driver`, `libva-intel-driver`,
  `vulkan-intel`, `zram-generator`.

PortProton, firmware e modelos de IA não entram no backup; baixe pelos links
oficiais.

## Repos de referência

- Digital do T480: <https://github.com/sshs3rejo/t480-fingerprint>
- Config do OpenCode: <https://github.com/sshs3rejo/opencode-config>
- Mount do GDrive: <https://github.com/sshs3rejo/gdrive-mount>
- Instalação do yay: <https://github.com/sshs3rejo/autoinstall_yay>
- Fix Wi-Fi WPA2-Enterprise: <https://github.com/sshs3rejo/enterprise-wifi-fix>
- Backups no GDrive: <https://github.com/sshs3rejo/backup-orchestrator>
- Base do desktop: <https://github.com/end-4/dots-hyprland>
- Quickshell (end4-pC): <https://github.com/pctrade/end4-pC>

## Depois de instalar

1. Windows 10, depois CachyOS com ESP de 4 GiB e Limine.
2. Restaurar o kit: `bootstrap.sh`, `restore.sh --stage all`, `verify.sh`.
3. Digital: clonar `t480-fingerprint`, rodar `./setup.sh` e `fprintd-enroll`.
4. Snapper da home: comandos acima.
5. GDrive/Notion: o kit monta e autentica; se o token expirar,
   `rclone config reconnect gdrive:`.
