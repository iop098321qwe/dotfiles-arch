# Grymm's Omarchy Quattro Dotfiles

This repository is a Chezmoi source tree for bootstrapping Grymm's Arch
Linux desktop from a brand new Omarchy Quattro install.

The commands in this guide assume the repository has been merged to `main`.

## Start From Omarchy Quattro

Begin with a clean Omarchy Quattro installation and a graphical desktop
session. Run the setup from an interactive terminal because several steps ask
for confirmation, credentials, or sudo access.

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

Rerun `chezmoi apply` any time a deferred interactive step needs to continue.

## Before Running Chezmoi

Complete these steps first:

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

Chezmoi reads `.chezmoi.toml.tmpl`, which registers
`.bootstrap-proton-pass.sh` as a pre-read source-state hook. The script checks
`CHEZMOI_COMMAND` and only bootstraps Proton Pass during `chezmoi init`, including
`chezmoi init --apply`. Every initialization checks installation and
authentication, installing Proton Pass CLI or prompting for login only when
needed.

Other commands, such as `chezmoi re-add`, `apply`, `diff`, and `status`, exit the
bootstrap immediately without invoking Proton Pass CLI. Direct script execution
also does nothing unless `CHEZMOI_COMMAND=init` is set. Other hooks that use
Proton Pass still require a valid session.

The apply hooks then install packages, write dotfiles, configure application
state, and enable services. This setup is intentionally side-effectful.

High-level system changes include:

- Install Pacman and AUR packages through `omarchy pkg` commands.
- Enable and start the Syncthing user service.
- Install, configure, log in to, import history for, and sync Atuin.
- Install Espanso, register its service, and start the user service, unless
  the user confirms the temporary AUR package bypass.
- Install missing required Espanso packages without updating installed ones.
- Enable and start the Cronie system service with sudo.
- Enable and start the Proton Mail Bridge user service.
- Enable and start the RustDesk system service with sudo.
- Authenticate GitHub CLI if needed before later setup hooks run.
- Clone `grymms_grimoires` after GitHub authentication is ready.
- Install tmux plugins with Tmux Plugin Manager.
- Install Spotify, Spicetify, and ACL tools when needed.
- Apply Spicetify customization after Spotify first-run setup is complete.
- Validate the configured crontab and prompt before installing it.
- Install and upgrade Yazi packages through `ya pkg`.
- Create a starter host-specific Hyprland monitor profile when missing.
- Install DisplayLink packages and optionally enable DisplayLink drivers.
- Deploy the pinned start-page theme companion on Omarchy machines.

## Espanso Packages

The Espanso setup hook ensures these packages are installed on each machine:

- `markdown-shortcuts` from Espanso Hub.
- `deeptree` from `https://github.com/iop098321qwe/deeptree_espanso`.

The hook uses `espanso package install` only for missing packages. If Espanso
installation is bypassed or the executable is unavailable, package setup is
also skipped. Rerun `chezmoi apply` when Espanso is available to complete setup.

Espanso owns everything under `~/.config/espanso/match/packages/`, including
package manifests and source metadata. This directory is ignored by Chezmoi;
existing installed packages remain in place when migrating from tracked copies.
Keep custom matches outside the package directory.

Update packages explicitly on each machine:

```sh
espanso package update all
```

The setup ensures the same required package set, not identical package versions.
It neither updates installed packages nor removes additional packages. To add a
required package, add an installation entry to
`.chezmoiscripts/run_002_espanso.sh`.

## Start-Page Theme Companion

The apply hook `.chezmoiscripts/run_after_003_theme_companion.sh` installs the
local Omarchy theme reader and Brave native messaging registrations. It
downloads a pinned revision from `iop098321qwe/main_page`, caches its source,
and reruns the idempotent installer on each apply. Linux machines without
Omarchy skip this step. Python 3.11 or newer and an authenticated GitHub CLI
are required. The hook reuses the earlier GitHub authentication step to read
the private companion repository; tokens are not embedded in the files.

After applying, open `brave://extensions`, enable Developer mode, and load
the unpacked extension from
`~/.local/share/grymm-theme-companion/extension`. The installer prints the
actual path and stable extension ID. `XDG_DATA_HOME` can change that path.
Perform this once per Brave Origin or standard Brave profile on each computer.
Chezmoi does not enable browser extensions automatically.

The GitHub Pages start page then follows the current local Omarchy palette
live. Without a working companion it uses its original Catppuccin colors.
No desktop theme is stored or synced between computers.

To update the companion, change the full revision SHA in the hook, then apply
the dotfiles on each computer. Reload the extension at `brave://extensions`
and reload open site tabs after updating unpacked extension files.
Removing the hook prevents future installation; removal of existing native
registrations is described in the companion guide.

See the [companion guide](https://github.com/iop098321qwe/main_page/blob/5fde175efb77c135ca3706c4b48fda2dd5384065/companion/README.md)
for installation, fallback, diagnosis, and removal. The guide link is a URL
line-length exception and includes Quattro state-directory discovery.

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
- `espanso-wayland` can be temporarily bypassed while its AUR build is broken.
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

- Proton Pass CLI login.
- GitHub CLI login before later setup hooks run.
- Spotify first-run confirmation before Spicetify applies.
- Sudo authentication for system services, ACL fixes, or package repair.
- Crontab installation confirmation.
- DisplayLink driver enablement and optional reboot.

If GitHub authentication is not ready, setup stops before hooks that require
GitHub access run.

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
