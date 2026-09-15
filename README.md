# Grymm's Omarchy Quattro Dotfiles

This repository is a Chezmoi source tree for bootstrapping Grymm's Arch
Linux desktop from a brand new Omarchy Quattro install.

The commands in this guide assume the repository has been merged to `main`.

## Start From Omarchy Quattro

Begin with a clean Omarchy Quattro installation and a graphical desktop
session. Run the setup from an interactive terminal because several steps ask
for confirmation, credentials, or sudo access.

Before running Chezmoi, use the Omarchy Quattro menu to switch Omarchy to the
`edge` channel. Restart after switching channels. The Chezmoi scripts enforce
`edge` automatically, but doing this first avoids stopping the initialization
mid-run for the channel switch and reboot.

Sign in to Spotify before running Chezmoi. The Spicetify setup can launch
Spotify and wait for first-run authentication, but signing in first makes the
initialization smoother.

## Quick Start

Install the tools needed to fetch and apply these dotfiles:

```sh
omarchy pkg add git
omarchy pkg add chezmoi
```

Initialize Chezmoi from the `main` branch and apply the dotfiles:

```sh
chezmoi init --apply iop098321qwe/dotfiles-arch
```

If the first run stops because Omarchy was switched to `edge`, reboot and run:

```sh
chezmoi apply
```

Rerun `chezmoi apply` any time a deferred interactive step needs to continue.

## Before Running Chezmoi

Complete these steps first:

- Switch Omarchy to the `edge` channel from the Omarchy Quattro menu.
- Restart after switching to `edge`.
- Sign in to Spotify.
- Keep Proton Pass credentials available for interactive login.
- Make sure the Proton Pass `Personal` vault contains an `Atuin` item.
- Be ready to authenticate GitHub CLI if prompted.
- Run the setup in a graphical session with an interactive terminal.

The Atuin setup expects the Proton Pass `Atuin` item to include these fields:

- `Username`
- `Password`
- `Atuin Key`

## What The Initialization Does

Chezmoi reads `.chezmoi.toml.tmpl`, which runs
`.bootstrap-proton-pass.sh` before reading source state. That bootstrap script
checks Omarchy `edge`, installs Proton Pass CLI when needed, and prompts for
Proton Pass authentication when needed.

The apply hooks then install packages, write dotfiles, configure application
state, and enable services. This setup is intentionally side-effectful.

High-level system changes include:

- Install Pacman and AUR packages through `omarchy pkg` commands.
- Enable and start the Syncthing user service.
- Install, configure, log in to, import history for, and sync Atuin.
- Install Espanso, register its service, and start the user service.
- Enable and start the Cronie system service with sudo.
- Enable and start the Proton Mail Bridge user service.
- Enable and start the RustDesk system service with sudo.
- Authenticate GitHub CLI if needed and clone `grymms_grimoires`.
- Install tmux plugins with Tmux Plugin Manager.
- Install Spotify, Spicetify, and ACL tools when needed.
- Apply Spicetify customization after Spotify first-run setup is complete.
- Validate the configured crontab and prompt before installing it.
- Install and upgrade Yazi packages through `ya pkg`.
- Create a starter host-specific Hyprland monitor profile when missing.
- Install DisplayLink packages and optionally enable DisplayLink drivers.

## Pacman Packages Installed

The setup installs these packages through `omarchy pkg add`:

- `7zip`
- `acl`
- `aria2`
- `atuin`
- `btop`
- `chezmoi`
- `cronie`
- `diffnav`
- `entr`
- `ffmpeg`
- `firefox`
- `git`
- `git-delta`
- `github-cli`
- `glow`
- `harper`
- `intel-media-driver`
- `linux-headers`
- `moreutils`
- `ncdu`
- `nmap`
- `npm`
- `openscad`
- `pandoc-cli`
- `proton-vpn-gtk-app`
- `protonmail-bridge`
- `python-curl_cffi`
- `solaar`
- `speedtest-cli`
- `spotify`
- `syncthing`
- `tailscale`
- `tealdeer`
- `television`
- `tmux`
- `trash-cli`
- `ttf-jetbrains-mono-nerd`
- `wireshark-cli`
- `wireshark-qt`
- `yazi`
- `yt-dlp`

`git` and `chezmoi` are listed because the quick-start commands install them
before initialization. Some packages are installed by dedicated hooks only when
that hook needs them.

## AUR Packages Installed

The setup installs these AUR packages through `omarchy pkg aur add`:

- `bambustudio-appimage`
- `betterbird-bin`
- `blesh-git`
- `brave-origin-bin`
- `displaylink`
- `espanso-wayland`
- `evdi-dkms`
- `gitflow-avh`
- `lazyssh-bin`
- `ocx`
- `opencode-bin`
- `powershell-bin`
- `proton-pass-cli-bin`
- `proton-pass-bin`
- `rustdesk-bin`
- `sesh-bin`
- `spicetify-cli`
- `t3code-bin`
- `tmux-plugin-manager`
- `ttl-bin`
- `tuxedo-bin`
- `vesktop-bin`
- `zennotes-bin`

## Interactive Prompts To Expect

The setup may prompt for:

- Omarchy `edge` channel confirmation if it was not changed ahead of time.
- Proton Pass CLI login.
- GitHub CLI login for cloning `grymms_grimoires`.
- Spotify first-run confirmation before Spicetify applies.
- Sudo authentication for system services, ACL fixes, or package repair.
- Crontab installation confirmation.
- DisplayLink driver enablement and optional reboot.

If GitHub authentication is not ready, the `grymms_grimoires` clone can be
deferred and retried on a later Chezmoi run.

## After The First Run

Inspect the source repository with:

```sh
chezmoi cd
git status --short
```

Apply future source changes with:

```sh
chezmoi apply
```

Do not use `chezmoi apply` as a harmless dry run. It runs hooks that can
install packages, start services, prompt for credentials, and change live
desktop configuration.
