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
- Browser extensions are installed separately from their GitHub repositories.

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

Chezmoi no longer deploys or updates the browser theme companion or Calendar
bridge. Install and update them from their dedicated GitHub repositories.
Existing installed paths are preserved, so current browser loading flags
continue working.

- [Omarchy theme sync](https://github.com/iop098321qwe/omarchy_theme_sync/tree/develop)
- [Notion Calendar desktop bridge](https://github.com/iop098321qwe/notion_calendar_desktop_bridge/tree/develop)

The links above are URL line-length exceptions. Each repository README has
clone, install, update, browser reload, and troubleshooting instructions.
`chezmoi apply` and `chezmoi update` no longer update these extensions.

## Notion Desktop

The package hook installs `notion-desktop` through `omarchy pkg add`, using
the same package as Omarchy Menu's Notion installer. Super+Shift+J launches
the desktop app or focuses an existing Notion window instead of opening the
website. The package supplies the app launcher and icon.

On a future apply, `.chezmoiremove` removes only the old user-level
`~/.local/share/applications/Notion.desktop` launcher and
`~/.local/share/icons/hicolor/256x256/apps/notion.png` icon. It does not remove
Notion app data or the package-owned launcher. Notion Calendar remains a web
app with its existing launcher and Super+Shift+C shortcut.

### Open Calendar Tasks In Notion Desktop

Install **Notion Calendar → Desktop** from its dedicated repository, linked
under [Start-Page Theme Companion](#start-page-theme-companion).
Its repository installer retains `~/.local/share/notion-calendar-desktop-bridge`.

If the extension was already loaded manually, click **Reload** on its card
in `brave://extensions` and approve any requested new permissions. Reload
Calendar too. Version 1.2.0 supports both Calendar domains,
`calendar.notion.com` and `calendar.notion.so`, and installs a direct click
handler before Calendar's scripts run. Reloading Calendar after the extension
is essential for this handler to take effect.

Click a task's **Manage in Notion** button. Normal task buttons and links now
launch the matching `notion://` URL directly from Calendar's existing tab,
without creating a tab, loading a forwarding page, or waking the background
worker. Calendar stays open in place. Approve the browser's external-app
prompt if shown; when offered, allow Calendar to open Notion links in future.
Browser security permissions cannot be bypassed by the extension.

The navigation worker remains a backup for navigation mechanisms the direct
handler cannot intercept, such as blank tabs assigned a destination later.
Only this backup route uses the local launch page. There, click **Open Notion
Desktop** if automatic opening is blocked, or **Continue in Notion web
instead** for web-only access. You may close that backup tab afterward.

The bridge redirects only supported task URLs opened from a top-level
`https://calendar.notion.com` or `https://calendar.notion.so` page.
Normal Notion browsing remains unchanged.
It requests navigation events, session storage, and access to Calendar and
the supported Notion hosts. Temporary session storage holds tab IDs only;
the extension reads no task bodies and sends no network requests. It does
not install a service, native host, or additional system protocol handler.

If Notion still does not launch, verify the protocol handler:

```sh
xdg-mime query default x-scheme-handler/notion
xdg-open 'notion://www.notion.so/REPLACE_WITH_YOUR_PAGE_ID'
```

Replace the placeholder with a real 32-character Notion page ID. If the
terminal command fails too, repair the Notion Desktop installation or its
handler before troubleshooting the browser extension. The protocol format
was manually verified on this machine; automated tests use simulated browser
events, not the authenticated Calendar UI.

For temporary web-only use, disable the extension in `brave://extensions`.
To stop automatic loading permanently, remove the bridge path from the
flags file. Chezmoi no longer registers it. Restart Brave Origin afterward.

Run extension tests from their dedicated repositories, not this source tree.

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
- `notion-desktop`
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
