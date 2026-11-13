# AGENTS.md

## Purpose

This file guides AI agents and human maintainers working in this repository.
All work must follow best practices and industry standards where applicable.
Prefer verified repository facts over assumptions, especially for dotfiles that
affect the user's live desktop, shell, services, and package set.

## Scope

This guide covers the Chezmoi source repository at this root. It applies to
tracked files that configure the user's Arch Linux and Omarchy environment.
It does not define upstream Omarchy behavior, Chezmoi internals, or private
service credentials outside this repository.

## Formatting Rules

- Limit lines in this file to 80 characters.
- Exceptions are allowed only for URLs, code blocks, hashes, tables, or
  unbreakable commands and paths.
- If a path must exceed 80 characters, keep it as a single code span and note
  that the path is an unbreakable path exception on the same line.
- Use CommonMark-compatible Markdown unless a file has a verified dialect.
- Keep bullets short and action-oriented.

## Quick Start

- Start with `git status --short` and review the worktree before editing.
- Edit Chezmoi source files in this repository, not generated target files.
- Use `git diff --check` as the safe baseline validation command.
- Do not run `chezmoi apply` as routine validation. It is side-effectful.
- Run `chezmoi apply` only when the user explicitly approves live changes.
- `README.md` documents the user-facing Omarchy Quattro bootstrap flow.

## Environment

- Target OS: Arch Linux with Omarchy, verified by package hooks and configs.
- Omarchy channel is not enforced; any channel can be used.
- Shell scripts use Bash via `#!/usr/bin/env bash`.
- Chezmoi manages this source tree, verified by `.chezmoi.toml.tmpl` and
  `.chezmoiscripts/`.
- `.chezmoi.toml.tmpl` enables Chezmoi git behavior and pre-read hook.
- `.bootstrap-proton-pass.sh` installs and authenticates `pass-cli` on init.
- The bootstrap requires `CHEZMOI_COMMAND=init`; other values or an unset
  variable skip all Proton Pass checks.
- `gh` is installed by the package hook and used to clone GitHub repositories.
- `nodejs` is installed explicitly for the Surfingkeys palette publisher;
  hooks use `/usr/bin/node` rather than shell version-manager shims.
- Interactive prompts use `gum` in several scripts.
- Some hooks call `sudo`, `systemctl`, `systemctl --user`, `pacman`, and
  Omarchy package commands.
- The Spicetify hook runs only on x86_64 because Spotify publishes no
  Linux build for other architectures.
- CBC version is `v3.7.0` in `executable_dot_custom_bash_commands.sh`.
- Verification needed: no pinned Chezmoi, Bash, Lua, Node, or Stylua version
  file was found.

## Repository Overview

- `.chezmoiscripts/` contains Chezmoi lifecycle hooks.
- `.chezmoitemplates/` contains reusable Chezmoi template source files.
- `dot_agents/` installs local agent skills and skill symlinks.
- `dot_config/` contains application and desktop configuration for `~/.config`.
- `dot_local/` contains files mapped under `~/.local`.
- `private_dot_ssh/` contains private Chezmoi-managed SSH data.
- Top-level `dot_*` files map to dotfiles in the target home directory.
- Top-level `private_*` files may contain sensitive target-home data.
- Top-level `executable_*` files map to executable target-home files.
- `tests/` contains isolated theme-sync tests and is ignored by Chezmoi.
- `AGENTS.md`, `CHANGELOG.md`, `LICENSE`, and local state files are ignored
  by Chezmoi through `.chezmoiignore`.

## Tracked Files Overview

This section lists tracked source and configuration files by directory. Private
paths are listed by purpose only; do not inspect their contents without a clear
task need and user approval.

### Root Control Files

- `.bootstrap-proton-pass.sh` bootstraps Proton Pass CLI only on init.
- `.chezmoi.toml.tmpl` configures Chezmoi git behavior and pre-read hook.
- `.chezmoiignore` excludes repository-only files, tests, installed Espanso
  packages, and Surfingkeys runtime palettes and backups.
- `.chezmoiremove` removes the retired Notion web-app launcher and icon.
- `AGENTS.md` is this repository operating guide.
- `CHANGELOG.md` is release history; never edit it directly.
- `LICENSE` is the repository license.
- `README.md` documents Omarchy Quattro bootstrap steps.
- `dot_autocompletions.sh` defines Bash completions for helper commands.
- `dot_bashrc` loads Omarchy Bash defaults and user shell sources.
- `dot_cbc_aliases.sh` defines CBC and shell aliases.
- `dot_exports.sh` defines editor, pager, NVM, and custom environment vars.
- `dot_inputrc` configures Readline vi-mode cursor behavior.
- `dot_sources.sh` sources shell helpers, completions, and exports.
- `executable_dot_custom_bash_commands.sh` implements CBC shell functions.
- `private_dot_npmrc` is private npm configuration; treat as sensitive.

### Chezmoi Scripts

- `.chezmoiscripts/run_before_001_sudo_auth.sh` starts passwordless sudo.
- `.chezmoiscripts/run_before_002_packages.sh` installs package sets, including
  the Omarchy-menu `notion-desktop` package.
- `.chezmoiscripts/run_000_github_auth.sh` authenticates GitHub CLI.
- `.chezmoiscripts/run_000_syncthing.sh` installs and starts Syncthing.
- `.chezmoiscripts/run_001_atuin.sh` installs, configures, and syncs Atuin.
- `.chezmoiscripts/run_002_espanso.sh` installs and starts Espanso, with a
  temporary gum bypass while the AUR package is broken. It also installs
  missing required Espanso packages without updating installed ones.
- `.chezmoiscripts/run_003_cronie.sh` installs and starts Cronie.
- `.chezmoiscripts/run_004_proton_mail_bridge.sh` installs Mail Bridge.
- `.chezmoiscripts/run_005_rustdesk.sh` installs and starts RustDesk.
- `.chezmoiscripts/run_006_grymms_grimoires.sh` clones grymms_grimoires.
- `.chezmoiscripts/run_after_000_tmux_plugins.sh` installs tmux plugins.
- `.chezmoiscripts/run_after_001_spicetify_bootstrap.sh.tmpl` applies
  Spotify and Spicetify setup after Spotify first-run is complete, and
  skips on non-x86_64 hosts where Spotify cannot run.
- `.chezmoiscripts/run_after_002_update_crontab.sh` validates and installs
  the user crontab after confirmation.
- `.chezmoiscripts/run_after_003_theme_companion.sh` deploys the pinned
  start-page native host and extension for Brave Origin and standard Brave,
  then configures automatic companion and Calendar bridge loading for
  Brave Origin.
- `.chezmoiscripts/run_after_004_surfingkeys_theme.sh` initializes the local
  Surfingkeys palette after files are deployed on supported Omarchy systems.
- `.chezmoiscripts/run_after_999_notify_complete.sh` prints completion notice
  and prompts for reboot.
- `.chezmoiscripts/run_once_after_000_yazi_packages.sh` adds Yazi packages.
- `.chezmoiscripts/run_once_before_000_bootstrap_hypr_monitors.sh.tmpl`
  creates a host monitor template when one is missing.
- `.chezmoiscripts/run_onchange_000_displaylink_setup.sh` installs and
  optionally enables DisplayLink drivers.

### Chezmoi Templates

- `.chezmoitemplates/hypr/monitors/grymm-aio-01.lua` defines AIO monitors.
- `.chezmoitemplates/hypr/monitors/grymm-lptp-09.lua` defines laptop
  monitor defaults.
- `.chezmoitemplates/hypr/monitors/grymm-lptp-work.lua` defines work monitor
  layout defaults.

### Agent Files

- `dot_agents/skills/find-skills/SKILL.md` installs a local skill document.
- `dot_agents/skills/symlink_*` entries link installed agent skills.

### Desktop And App Config

- `dot_config/alacritty/alacritty.toml` configures Alacritty.
- `dot_config/autostart/*.desktop` defines desktop autostart entries.
- `dot_config/btop/btop.conf` configures btop.
- `dot_config/btop/themes/symlink_current.theme` links the active btop theme.
- `dot_config/cbc/cbc.config` configures CBC behavior.
- `dot_config/cbc/packages.toml` records CBC module dependencies.
- `dot_config/cron/private_crontab.current` is a private crontab source.
- `dot_config/eza/symlink_theme.yml` links the active eza theme.
- `dot_config/fcitx5/conf/*` configures Fcitx5.
- `dot_config/fcitx5/private_profile` is private Fcitx5 profile data.
- `dot_config/foot/foot.ini` configures Foot.
- `dot_config/gh-dash/config.yml` configures gh-dash.
- `dot_config/gh/private_config.yml` is private GitHub CLI config.
- `dot_config/ghostty/config` configures Ghostty.
- `dot_config/git/config` configures Git aliases, user, delta, and pulls.
- `dot_config/harper-ls/dictionary.txt` customizes Harper dictionary words.
- `dot_config/hypr/*.lua` configures Hyprland through Omarchy Lua modules.
- `dot_config/hypr/*.conf` configures Hyprland-related services.
- `dot_config/hypr/theme-workaround.lua` adds a Brave Origin policy-refresh
  guard to the session PATH until Omarchy issue #16365 is fixed.
- `dot_config/hypr/private_monitors.lua.tmpl` is private monitor config.
- `dot_config/hyprland-preview-share-picker/config.yaml` configures sharing.
- `dot_config/imv/config` configures imv.
- `dot_config/kitty/kitty.conf` configures Kitty.
- `dot_config/lazydocker/empty_config.yml` is a placeholder config.
- `dot_config/lazygit/config.yml` configures Lazygit.
- `dot_config/mimeapps.list` configures default application handlers.
- `dot_config/starship.toml` configures the shell prompt.
- `dot_config/starship_yazi.toml` configures Starship for Yazi.
- `dot_config/surfingkeys/catppuccin-mocha-surfingkeys.js.tmpl` themes
  Surfingkeys with a home-specific, URL-encoded local palette URL.
- `dot_config/surfingkeys/omarchy-theme.cjs` validates and atomically publishes
  Omarchy colors without rewriting unchanged palettes or managed scripts.
- `dot_config/tensaku/config.toml` configures Tensaku.
- `dot_config/tmux/tmux.conf` configures tmux keybindings and plugins.
- `dot_config/tmux/dot_planning/config.json` configures tmux planning data.
- `dot_config/tmux/scripts/open-daily-summaries.sh` opens or focuses the
  marked Daily Summaries Yazi pane within the current tmux session.
- `dot_config/tmux/scripts/open-sesh.sh` opens Sesh with an Omarchy-colored
  popup background and accent border, reading the palette at launch.
- `dot_config/tmux/scripts/open-tuxedo.sh` opens or focuses Tuxedo for the
  current directory within the current tmux session.
- `dot_config/tuxedo/config.toml` configures Tuxedo.
- `dot_config/user-dirs.dirs` configures XDG user directories.
- `dot_config/voxtype/config.toml` configures Voxtype.
- `dot_config/xkb/rules/grymm` extends system rules with the personal Compose
  option used by `dot_config/hypr/input.lua`.
- `dot_config/xkb/symbols/grymm` adds Shift+Escape Compose after the personal
  Caps/Escape swap, with explicit actions that preserve Caps Lock state.

### Espanso Config

- `dot_config/espanso/config/default.yml` configures Espanso defaults.
- `dot_config/espanso/match/base.yml` is a base Espanso match file.
- `dot_config/espanso/match/coding/` contains coding text expansions.
- `dot_config/espanso/match/globals/` contains global text expansions.
- `dot_config/espanso/match/testing/` contains test match definitions.
- `dot_config/espanso/match/variables/` contains Espanso variables.
- `dot_config/espanso/match/work/` may contain work-specific expansions.
- `dot_config/espanso/scripts/.keep` preserves the scripts directory.

### Neovim Config

- `dot_config/nvim/.neoconf.json` configures Neoconf.
- `dot_config/nvim/init.lua` boots LazyVim and user modules.
- `dot_config/nvim/lazyvim.json` records enabled LazyVim extras.
- `dot_config/nvim/lua/config/*.lua` configures LazyVim behavior.
- `dot_config/nvim/lua/plugins/*.lua` defines plugin overrides.
- `dot_config/nvim/plugin/after/transparency.lua` applies transparency.
- `dot_config/nvim/snippets/all.json` defines global snippets.
- `dot_config/nvim/snippets/package.json` declares snippet metadata.
- `dot_config/nvim/spell/*` stores custom spelling data.
- `dot_config/nvim/stylua.toml` configures Stylua for Lua files.

### Omarchy Config

- `dot_config/omarchy/branding/*.txt` customizes branding text.
- `dot_config/omarchy/defaults/agent` sets the default agent to OpenCode.
- `dot_config/omarchy/extensions/omarchy-menu.jsonc` extends Omarchy menu.
- `dot_config/omarchy/hooks/*` contains Omarchy hook scripts.
- `dot_config/omarchy/hooks/theme-set.d/executable_40-surfingkeys.sh`
  refreshes Surfingkeys colors with a bounded runtime and state-directory log.
- `dot_config/omarchy/workarounds/bin/executable_brave-origin` bounds Brave
  Origin policy refreshes without changing ordinary browser launches.
- `dot_config/omarchy/plugins/grymm.*` contains local menu and overlay clones
  with Ctrl-based Vim navigation.
- Each clone's `dot_omarchy-upstream/` stores its packaged source baseline.
- `dot_config/omarchy/shell.json` configures Omarchy shell UI.
- `dot_config/omarchy/themed/*.sample` stores theme template samples.
- `dot_config/omarchy/themed/television.toml.tpl` maps the Omarchy palette
  to accent-based Television UI colors during theme generation.

### OpenCode Config

- `dot_config/opencode/opencode.json` configures OpenCode.
- `dot_config/opencode/package-lock.json` locks OpenCode config dependencies.
- `dot_config/opencode/settings.json` configures OpenCode settings.
- `dot_config/opencode/snippet/*.md` defines OpenCode snippets.
- `dot_config/opencode/snippet/config.jsonc` configures snippet behavior.
- `dot_config/opencode/tui.json` configures the OpenCode TUI.

### Private App Config

- `dot_config/private_atuin/private_config.toml` is private Atuin config.
- `dot_config/private_spicetify/` stores private Spicetify config paths.
- `dot_config/private_vesktop/` stores private Vesktop settings and themes.
- `dot_config/rclone/private_empty_rclone.conf` is private rclone config.
- `private_dot_ssh/private_known_hosts` is private SSH known-hosts data.

### Television And Yazi Config

- `dot_config/television/config.toml` configures Television.
- `dot_config/television/themes/symlink_omarchy.toml` links Television to
  the generated active Omarchy theme using a home-relative link.
- `dot_config/television/cable/*.toml` defines Television cable sources.
- `dot_config/television/cable/.keep` preserves the cable directory.
- `dot_config/yazi/init.lua` configures Yazi Lua startup.
- `dot_config/yazi/keymap.toml` configures Yazi keybindings.
- `dot_config/yazi/theme.toml` configures Yazi theme behavior.
- `dot_config/yazi/yazi.toml` configures Yazi managers and previewers.

### Local Bin

- `dot_local/bin/executable_grymm-theme-companion-browser-setup` merges the
  installed companion and optional Calendar bridge into Brave Origin's
  extension-loading launch flags.
- `dot_local/bin/executable_cron_mirror.sh` is an executable local script.
- `dot_local/bin/executable_omarchy-cloned-plugin-diff` reports upstream
  changes to cloned Omarchy plugins.

### Local Share Extensions And Web Apps

- `dot_local/share/notion-calendar-desktop-bridge/background.mjs` routes
  Calendar-origin task navigations through a local desktop-launch page.
- `dot_local/share/notion-calendar-desktop-bridge/launch.html` provides
  desktop-launch and web-fallback links.
- `dot_local/share/notion-calendar-desktop-bridge/launch.mjs` attempts the
  desktop handoff while preserving an explicit user-click fallback.
- `dot_local/share/notion-calendar-desktop-bridge/links.mjs` validates
  supported task URLs and converts page IDs into desktop links.
- `dot_local/share/notion-calendar-desktop-bridge/manifest.json` declares
  the navigation worker, session storage, and scoped Notion host access.

The following desktop entries live in `dot_local/share/applications/`.
Each `executable_*.desktop` file installs a custom Omarchy web-app launcher.

- `executable_Amazon.desktop` opens Amazon.
- `executable_Claude.desktop` opens a new Claude conversation.
- `executable_Deeptree Matrix.desktop` opens Deeptree Matrix.
- `executable_Deeptree Nextcloud.desktop` opens Deeptree Nextcloud.
- `executable_Emby.desktop` opens the Emby web app.
- `executable_Figma.desktop` opens Figma.
- `executable_Fizzy.desktop` opens Fizzy.
- `executable_GitHub.desktop` opens GitHub.
- `executable_MakerWorld.desktop` opens MakerWorld.
- `executable_Notion Calendar.desktop` opens Notion Calendar.
- `executable_Proton Mail.desktop` opens Proton Mail.
- `executable_Reddit.desktop` opens Reddit.
- `executable_Snapchat.desktop` opens Snapchat's web app.
- `executable_Suno.desktop` opens Suno.
- `executable_Tailscale.desktop` opens the Tailscale admin machines page.
- `executable_Twitch.desktop` opens Twitch.
- `dot_local/share/icons/hicolor/` stores the launchers' generated PNG icon
  assets, summarized here rather than listed individually.

### Tests

- `tests/notion-calendar-desktop-bridge.cjs` tests task URL conversion,
  source-tab scoping, navigation races, worker restart, and launch fallback.
- `tests/surfingkeys-theme.cjs` tests palette validation, atomic publication,
  home-specific template rendering, and isolated apply and theme-change hooks.
- `tests/test_theme_companion.py` tests browser flag merging, backups,
  idempotence, XDG paths, symlinks, permissions, missing extensions, and
  loading the Calendar bridge alongside the companion.

## Architecture

- This repository is a Chezmoi source tree for home-directory dotfiles.
- Chezmoi names map source files into targets, such as `dot_bashrc` to
  `~/.bashrc` and `dot_config/*` to `~/.config/*`.
- `.chezmoi.toml.tmpl` runs `.bootstrap-proton-pass.sh` before reading state.
- The bootstrap checks Proton Pass on every `chezmoi init`, including
  `init --apply`, and exits immediately for other commands or direct execution
  without `CHEZMOI_COMMAND=init`.
- `.chezmoiscripts/run_before_001_sudo_auth.sh` starts passwordless sudo
  before package installation.
- `.chezmoiscripts/run_000_github_auth.sh` authenticates GitHub CLI early.
- `.chezmoiscripts/` hooks install packages, start services, configure apps,
  clone repositories, and prompt for reboots or confirmation.
- The theme companion hook downloads five source files from a pinned
  `main_page` revision on Linux with Omarchy. It caches them under
  `XDG_CACHE_HOME`, or `~/.cache`, and reruns the installer on each apply.
- The companion uses `XDG_CONFIG_HOME` and `XDG_DATA_HOME` with home defaults.
- After companion deployment, the browser helper merges its installed path
  and the Calendar bridge path, when installed, into `brave-origin-flags.conf`
  without dropping Omarchy extensions or other flags. It backs up changed
  existing files, preserves permissions and symlinks, and avoids rewriting
  unchanged files. Fully restart Brave Origin to load both extensions;
  standard Brave still requires manual enablement.
- The Calendar bridge is deployed under the standard Chezmoi data target,
  `~/.local/share/notion-calendar-desktop-bridge`; automatic pairing with
  the XDG-aware companion helper assumes the default data directory.
- Calendar-origin task navigation opens a local extension page that attempts
  the desktop protocol and offers an explicit clickable fallback. Browser
  navigation events cover same-tab links and script-created target tabs.
  Both `https://calendar.notion.com` and `https://calendar.notion.so` are
  accepted source origins and have explicit host permissions.
  Session storage tracks source tab IDs across MV3 worker suspension; it
  does not retain task URLs. Independently opened Notion tabs are unchanged.
- Surfingkeys polls a local palette published from `omarchy-theme-color --all`.
  Chezmoi installs the publisher and executable theme-set hook, then initializes
  the palette without changing the desktop theme. Systems without Omarchy or
  its color command skip initialization. Runtime palettes remain untracked.
- Palette discovery prefers the Quattro `XDG_STATE_HOME` layout and falls
  back to the older config layout only when the state layout is absent.
- Hyprland config starts from Omarchy defaults and loads local Lua overrides.
- Personal replacement bindings use native `o.rebind`; input uses the `grymm`
  XKB rules with US/German layouts and user-owned shifted-Compose symbols.
- Super+Shift+J launches `notion-desktop` and focuses its `notion` window class.
  The package owns Notion's desktop entry and icon; Notion Calendar stays a
  custom web app. `.chezmoiremove` cleans up the old Notion web-app files.
- Custom web apps are ordinary desktop entries that call
  `omarchy-launch-webapp`. Chezmoi installs their launchers and icons directly;
  no per-machine downloads or installation hook is required.
- Web-app icons use theme names resolved from the user's hicolor icon directory,
  with no username-specific absolute paths in desktop entries.
- Keep Omarchy's default web-app launchers outside Chezmoi management so
  Omarchy updates retain ownership of their behavior.
- Television uses the `omarchy` theme, generated from its user template on
  Omarchy theme changes. Reopen the picker to load updated colors.
- The Sesh binding calls `open-sesh.sh` with the originating pane and client.
  It matches the popup surface and rounded frame to the active palette.
- Bash loads Omarchy defaults, then `~/.sources.sh`, then Atuin init.
- CBC functions are implemented in `executable_dot_custom_bash_commands.sh`
  and configured through `dot_config/cbc/`.

## Commands

- `node --test tests/notion-calendar-desktop-bridge.cjs`: run bridge tests.
- `node --test tests/surfingkeys-theme.cjs`: run palette and hook tests.
- `python3 -m unittest discover -s tests -p 'test_*.py'`: run browser setup
  tests.
- `git status --short`: inspect pending work.
- `git diff --check`: check whitespace errors before commit.
- `git diff -- AGENTS.md .chezmoiignore`: review this guide integration.
- `chezmoi apply`: apply dotfiles and run hooks; user approval required.
- `cbc pkg load`: install and source CBC modules from the manifest.
- `cbc pkg update`: update installed CBC modules and refresh the manifest.
- `omarchy-cloned-plugin-diff`: show upstream changes to local plugin clones.
- `omarchy-cloned-plugin-diff --summary`: list changed clone files only.
- `ya pkg add <github-shorthand>`: add Yazi packages from GitHub shorthand.
- `espanso package update all`: update installed Espanso packages explicitly.
- Verification needed: no Makefile, justfile, or package script centralizes
  project commands.

## Testing

- Node's built-in test runner covers Surfingkeys and the Calendar bridge;
  Python's standard unittest covers Brave Origin extension loading.
- Tests use temporary homes and fake Omarchy commands, not live browser
  profiles or desktop settings. Hook tests require `/usr/bin/node` and Chezmoi.
- Calendar tests simulate browser navigation APIs; they do not confirm the
  authenticated live UI or OS protocol prompt end to end.
- No `*.bats` files were found.
- Use `git diff --check` for safe whitespace validation.
- Review shell edits manually for quoting, idempotence, and side effects.
- Do not execute Chezmoi hooks as tests unless the user asks for live changes.
- Verification needed: no coverage requirements or test gates are defined.

## Linting and Formatting

- No `.editorconfig` was found.
- No `.shellcheckrc` was found.
- `dot_config/nvim/stylua.toml` configures Stylua with tabs, width 4, and
  column width 120.
- Verification needed: no repository command was found for ShellCheck, Stylua,
  Prettier, Taplo, or Markdown linting.
- For Markdown, prefer CommonMark-compatible syntax and about 80 columns.

## CI and Release

- No `.github/` workflow directory was found.
- No release workflow was found.
- `CHANGELOG.md` exists, but agents must never edit it directly.
- Ask for the release process or automation before changelog changes.
- Verification needed: required status checks and deployment steps are not
  documented in this repository.

## Conventions

- Keep changes minimal and specific to the user's request.
- Do not make live desktop, package, service, or reboot changes without user
  approval.
- Preserve Chezmoi naming conventions such as `dot_`, `private_`, and
  `executable_`.
- Treat files and directories containing `private_`, `personal`, `work`, or
  `credentials` as sensitive.
- Use Bash safety practices for shell edits: quote expansions, prefer arrays,
  and keep scripts idempotent when hooks may rerun.
- If a change affects `README.md` accuracy, prompt to update `README.md`.
- Keep `README.md` updates in a separate commit from code or config changes.
- Prefer Conventional Commits for new commits.
- Write standalone, changelog-ready commit headers; keep bodies supplemental.
- Verification needed: release-note type filters are not defined in this repo.
- Commit-history hygiene: prefer amending small related corrections into the
  relevant current-branch commit instead of creating separate `fixup`,
  `chore`, or cleanup commits, unless the user requests a separate commit or
  amending would rewrite shared history unexpectedly.
- Agents must never read, create, edit, delete, move, stage, commit, or
  otherwise touch `todo.txt`; only the user may modify it manually.

## Security and Compliance

- Do not print, copy, or summarize private file contents unless the user asks.
- Do not expose secrets from npm, SSH, GitHub, rclone, Atuin, Vesktop,
  Spicetify, Espanso, Proton, or work-specific paths.
- Avoid running scripts that authenticate, install packages, enable services,
  clone repositories, change ACLs, or reboot without explicit user approval.
- `.bootstrap-proton-pass.sh` may start Proton Pass login only on init.
- `.chezmoiscripts/run_before_001_sudo_auth.sh` may start sudo.
- `.chezmoiscripts/run_000_github_auth.sh` may start GitHub login.
- `.chezmoiscripts/run_onchange_000_displaylink_setup.sh` can run `reboot now`.
- Verification needed: no compliance framework is documented.

## Dependencies and Services

- Omarchy package manager commands install Pacman and AUR packages.
- Syncthing user service is enabled by `run_000_syncthing.sh`.
- Espanso user service is registered and started by `run_002_espanso.sh`,
  unless the user confirms the temporary AUR bypass.
- The Espanso hook installs missing `markdown-shortcuts` from the Hub and
  `deeptree` from `https://github.com/iop098321qwe/deeptree_espanso`.
- Espanso owns installed package contents and metadata; Chezmoi ignores
  `.config/espanso/match/packages/`. The hook does not update or remove
  packages.
- Cronie system service is enabled by `run_003_cronie.sh`.
- Proton Mail Bridge user service is enabled by `run_004_proton_mail_bridge.sh`.
- RustDesk system service is enabled by `run_005_rustdesk.sh`.
- `grymms_grimoires` is cloned under `~/Documents` by
  `run_006_grymms_grimoires.sh`.
- DisplayLink and EVDI are installed by the onchange DisplayLink hook.
- Atuin history sync is configured by `run_001_atuin.sh`.
- Tmux Plugin Manager installs tmux plugins after apply.
- Yazi packages are added through `ya pkg add` with GitHub shorthand.
- LazyVim and lazy.nvim are bootstrapped by Neovim config.
- The Omarchy post-update hook reports packaged plugin drift without changing
  clone files or their baselines.
- The optional start-page theme companion uses Python 3.11+, authenticated
  GitHub CLI downloads, and Brave native messaging. It installs no service
  and opens no listening port.
- Surfingkeys theme sync uses Arch Node.js and Omarchy's color command.
  Browser setup must load the managed local Surfingkeys configuration and
  allow the extension to access file URLs; Chezmoi does not edit profiles.

## Troubleshooting

- During `chezmoi init`, `.bootstrap-proton-pass.sh` installs missing Proton
  Pass CLI through Omarchy's AUR helper and authenticates when needed.
- If Atuin is not logged in, the Atuin hook reads credentials from Proton Pass.
- If GitHub is not logged in, `run_000_github_auth.sh` runs
  `gh auth login -cw`.
- If Espanso fails to start, check `systemctl --user status espanso.service`.
- If `espanso-wayland` fails to build, use the hook's temporary bypass and
  follow its PKGBUILD icon rename workaround instructions.
- If crontab update fails, inspect `~/.config/cron/crontab.current` syntax.
- If Spotify first run is incomplete, the Spicetify hook defers setup until
  Spotify has launched and stored its version in prefs.
- On `aarch64`, the Spicetify hook exits successfully without installing
  Spotify because the official Linux client is x86-64 only.
- If tmux plugins do not install, verify tmux, git, the tmux config, and TPM.
- If DisplayLink setup runs, expect interactive confirmation and possible
  reboot prompt.
- If clone drift is reported, run `omarchy-cloned-plugin-diff` for a full diff.
- For start-page theme fallback, verify the unpacked extension is enabled
  and its native host is installed for the matching Brave browser.
- For Calendar task links, reload the bridge after updates and approve its
  permissions. Use its launch-page button if automatic launch is blocked,
  and verify `xdg-mime query default x-scheme-handler/notion` if needed.
- If the Brave Origin companion is absent, check `brave-origin-flags.conf`
  includes its installed extension path, fully exit the browser, and reopen
  it. `chezmoi update` must pull a branch containing both theme setup hooks.
- For Surfingkeys fallback, check the local configuration URL and file URL
  permission, then inspect `surfingkeys-theme.log` in Omarchy's state directory
  under `XDG_STATE_HOME` or `~/.local/state`.

## Refining Existing AGENTS.md

- Verify every statement against the repository before changing guidance.
- Remove stale, duplicated, or speculative content.
- Keep the required section order from this document.
- Replace vague guidance with exact commands and paths.
- Add `Verification needed` notes when the source of truth is missing.
- Optimize for AI consumption with short, atomic bullets.
- Re-check sensitive-path guidance when new private files are added.

## Maintenance

- Run the self-audit loop after any code, config, or documentation change.
- Re-scan the repo structure, tracked files, commands, and workflows.
- Compare this file to current repository behavior and update mismatches.
- Compare `README.md` to setup behavior and prompt for a separate update
  commit when commands, packages, services, or initialization steps change.
- Keep the tracked files overview aligned with tracked source and config files.
- Confirm the `todo.txt` manual-only rule remains explicit.
- Remove any update notes or logs from this file.
- Do not record AGENTS.md change history inside AGENTS.md.
