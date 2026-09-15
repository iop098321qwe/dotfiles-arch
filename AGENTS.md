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
- Verification needed: no README or script defines a non-mutating full setup
  command for this repository.

## Environment

- Target OS: Arch Linux with Omarchy, verified by package hooks and configs.
- Omarchy channel: `edge`, enforced by `.ensure-omarchy-edge.sh`.
- Shell scripts use Bash via `#!/usr/bin/env bash`.
- Chezmoi manages this source tree, verified by `.chezmoi.toml.tmpl` and
  `.chezmoiscripts/`.
- `.chezmoi.toml.tmpl` enables Chezmoi git behavior and pre-read hook.
- `pass-cli` is installed and authenticated by `.bootstrap-proton-pass.sh`.
- Interactive prompts use `gum` in several scripts.
- Some hooks call `sudo`, `systemctl`, `systemctl --user`, `pacman`, and
  Omarchy package commands.
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
- `AGENTS.md`, `CHANGELOG.md`, `LICENSE`, the Omarchy edge helper, and
  local state files are ignored by Chezmoi through `.chezmoiignore`.

## Tracked Files Overview

This section lists tracked source and configuration files by directory. Private
paths are listed by purpose only; do not inspect their contents without a clear
task need and user approval.

### Root Control Files

- `.bootstrap-proton-pass.sh` installs and authenticates Proton Pass CLI.
- `.chezmoi.toml.tmpl` configures Chezmoi git behavior and pre-read hook.
- `.chezmoiignore` excludes repository-only files from Chezmoi apply.
- `.ensure-omarchy-edge.sh` requires Omarchy edge before initialization.
- `AGENTS.md` is this repository operating guide.
- `CHANGELOG.md` is release history; never edit it directly.
- `LICENSE` is the repository license.
- `dot_autocompletions.sh` defines Bash completions for helper commands.
- `dot_bashrc` loads Omarchy Bash defaults and user shell sources.
- `dot_cbc_aliases.sh` defines CBC and shell aliases.
- `dot_exports.sh` defines editor, pager, NVM, and custom environment vars.
- `dot_inputrc` configures Readline vi-mode cursor behavior.
- `dot_sources.sh` sources shell helpers, completions, and exports.
- `executable_dot_custom_bash_commands.sh` implements CBC shell functions.
- `private_dot_npmrc` is private npm configuration; treat as sensitive.

### Chezmoi Scripts

- `.chezmoiscripts/run_before_000_omarchy_channel.sh.tmpl` checks edge.
- `.chezmoiscripts/run_before_001_packages.sh` installs package sets.
- `.chezmoiscripts/run_000_syncthing.sh` installs and starts Syncthing.
- `.chezmoiscripts/run_001_atuin.sh` installs, configures, and syncs Atuin.
- `.chezmoiscripts/run_002_espanso.sh` installs and starts Espanso.
- `.chezmoiscripts/run_003_cronie.sh` installs and starts Cronie.
- `.chezmoiscripts/run_004_proton_mail_bridge.sh` installs Mail Bridge.
- `.chezmoiscripts/run_005_rustdesk.sh` installs and starts RustDesk.
- `.chezmoiscripts/run_after_000_tmux_plugins.sh` installs tmux plugins.
- `.chezmoiscripts/run_after_001_spicetify_bootstrap.sh.tmpl` applies
  Spotify and Spicetify setup after Spotify first-run is complete.
- `.chezmoiscripts/run_after_002_update_crontab.sh` validates and installs
  the user crontab after confirmation.
- `.chezmoiscripts/run_after_999_notify_complete.sh` prints completion notice.
- `.chezmoiscripts/run_once_after_000_yazi_packages.sh` installs Yazi plugins.
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
- `dot_config/hypr/private_monitors.lua.tmpl` is private monitor config.
- `dot_config/hyprland-preview-share-picker/config.yaml` configures sharing.
- `dot_config/imv/config` configures imv.
- `dot_config/kitty/kitty.conf` configures Kitty.
- `dot_config/lazydocker/empty_config.yml` is a placeholder config.
- `dot_config/lazygit/config.yml` configures Lazygit.
- `dot_config/mimeapps.list` configures default application handlers.
- `dot_config/starship.toml` configures the shell prompt.
- `dot_config/starship_yazi.toml` configures Starship for Yazi.
- `dot_config/surfingkeys/catppuccin-mocha-surfingkeys.js` themes
  Surfingkeys.
- `dot_config/tensaku/config.toml` configures Tensaku.
- `dot_config/tmux/tmux.conf` configures tmux keybindings and plugins.
- `dot_config/tmux/dot_planning/config.json` configures tmux planning data.
- `dot_config/tuxedo/config.toml` configures Tuxedo.
- `dot_config/user-dirs.dirs` configures XDG user directories.
- `dot_config/voxtype/config.toml` configures Voxtype.

### Espanso Config

- `dot_config/espanso/config/default.yml` configures Espanso defaults.
- `dot_config/espanso/match/base.yml` is a base Espanso match file.
- `dot_config/espanso/match/coding/` contains coding text expansions.
- `dot_config/espanso/match/globals/` contains global text expansions.
- `dot_config/espanso/match/packages/markdown-shortcuts/` is a tracked
  Espanso package for Markdown shortcuts.
- `dot_config/espanso/match/personal/` may contain personal expansions.
- `dot_config/espanso/match/testing/` contains test match definitions.
- `dot_config/espanso/match/variables/` contains Espanso variables.
- `dot_config/espanso/match/work/` may contain work-specific expansions.
- `dot_config/espanso/scripts/credential-generator.sh` generates credentials.
- `dot_config/espanso/scripts/credential-generator.sh.bak` is a backup script.

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
- `dot_config/omarchy/plugins/grymm.*` contains local menu and overlay clones
  with Ctrl-based Vim navigation.
- Each clone's `dot_omarchy-upstream/` stores its packaged source baseline.
- `dot_config/omarchy/shell.json` configures Omarchy shell UI.
- `dot_config/omarchy/themed/*.sample` stores theme template samples.

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
- `dot_config/television/cable/*.toml` defines Television cable sources.
- `dot_config/television/cable/.keep` preserves the cable directory.
- `dot_config/yazi/flavors/catppuccin-mocha.yazi/` contains a tracked Yazi
  flavor, license files, README, preview, and theme data.
- `dot_config/yazi/init.lua` configures Yazi Lua startup.
- `dot_config/yazi/keymap.toml` configures Yazi keybindings.
- `dot_config/yazi/package.toml` records Yazi plugin and flavor deps.
- `dot_config/yazi/theme.toml` configures Yazi theme behavior.
- `dot_config/yazi/yazi.toml` configures Yazi managers and previewers.

### Local Bin

- `dot_local/bin/executable_cron_mirror.sh` is an executable local script.
- `dot_local/bin/executable_omarchy-cloned-plugin-diff` reports upstream
  changes to cloned Omarchy plugins.

## Architecture

- This repository is a Chezmoi source tree for home-directory dotfiles.
- Chezmoi names map source files into targets, such as `dot_bashrc` to
  `~/.bashrc` and `dot_config/*` to `~/.config/*`.
- `.chezmoi.toml.tmpl` runs `.bootstrap-proton-pass.sh` before reading state.
- `.bootstrap-proton-pass.sh` calls `.ensure-omarchy-edge.sh` first.
- `.ensure-omarchy-edge.sh` requires `omarchy version channel` to be `edge`.
- `.chezmoiscripts/` hooks install packages, start services, configure apps,
  and prompt for reboots or confirmation.
- Hyprland config starts from Omarchy defaults and loads local Lua overrides.
- Bash loads Omarchy defaults, then `~/.sources.sh`, then Atuin init.
- CBC functions are implemented in `executable_dot_custom_bash_commands.sh`
  and configured through `dot_config/cbc/`.

## Commands

- `git status --short`: inspect pending work.
- `git diff --check`: check whitespace errors before commit.
- `git diff -- AGENTS.md .chezmoiignore`: review this guide integration.
- `chezmoi apply`: apply dotfiles and run hooks; user approval required.
- `bash .ensure-omarchy-edge.sh`: check or prompt for Omarchy edge.
- `cbc pkg load`: install and source CBC modules from the manifest.
- `cbc pkg update`: update installed CBC modules and refresh the manifest.
- `omarchy-cloned-plugin-diff`: show upstream changes to local plugin clones.
- `omarchy-cloned-plugin-diff --summary`: list changed clone files only.
- `ya pkg install`: install Yazi packages from `dot_config/yazi/package.toml`.
- `ya pkg upgrade`: upgrade Yazi packages.
- Verification needed: no Makefile, justfile, or package script centralizes
  project commands.

## Testing

- No dedicated automated test suite was found.
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
- Prefer Conventional Commits for new commits.
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
  change ACLs, or reboot without explicit user approval.
- `.bootstrap-proton-pass.sh` may start an interactive Proton Pass login.
- `.chezmoiscripts/run_onchange_000_displaylink_setup.sh` can run `reboot now`.
- Verification needed: no compliance framework is documented.

## Dependencies and Services

- Omarchy package manager commands install Pacman and AUR packages.
- Syncthing user service is enabled by `run_000_syncthing.sh`.
- Espanso user service is registered and started by `run_002_espanso.sh`.
- Cronie system service is enabled by `run_003_cronie.sh`.
- Proton Mail Bridge user service is enabled by `run_004_proton_mail_bridge.sh`.
- RustDesk system service is enabled by `run_005_rustdesk.sh`.
- DisplayLink and EVDI are installed by the onchange DisplayLink hook.
- Atuin history sync is configured by `run_001_atuin.sh`.
- Tmux Plugin Manager installs tmux plugins after apply.
- Yazi plugins are managed through `ya pkg` and `package.toml`.
- LazyVim and lazy.nvim are bootstrapped by Neovim config.
- The Omarchy post-update hook reports packaged plugin drift without changing
  clone files or their baselines.

## Troubleshooting

- If Omarchy is not on edge, `.ensure-omarchy-edge.sh` prompts to switch and
  defers initialization until after reboot.
- If `pass-cli` is missing, `.bootstrap-proton-pass.sh` installs Proton Pass
  CLI through Omarchy and requires authentication.
- If Atuin is not logged in, the Atuin hook reads credentials from Proton Pass.
- If Espanso fails to start, check `systemctl --user status espanso.service`.
- If crontab update fails, inspect `~/.config/cron/crontab.current` syntax.
- If Spotify first run is incomplete, the Spicetify hook defers setup until
  Spotify has launched and stored its version in prefs.
- If tmux plugins do not install, verify tmux, git, the tmux config, and TPM.
- If DisplayLink setup runs, expect interactive confirmation and possible
  reboot prompt.
- If clone drift is reported, run `omarchy-cloned-plugin-diff` for a full diff.

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
- Keep the tracked files overview aligned with tracked source and config files.
- Confirm the `todo.txt` manual-only rule remains explicit.
- Remove any update notes or logs from this file.
- Do not record AGENTS.md change history inside AGENTS.md.
