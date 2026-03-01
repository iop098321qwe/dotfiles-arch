# Arch Dotfiles

This repository contains my Arch Linux dotfiles and setup scripts, managed with
chezmoi.

## What This Guide Covers

This README walks through a full setup with:

1. Installing `yay` (AUR helper)
2. Installing `chezmoi` with `yay`
3. Initializing `chezmoi` with this dotfiles repo
4. Reviewing changes before writing files
5. Applying the dotfiles to your system

## 1) Install `yay` (if not already installed)

If `yay` is already available on your system, skip to step 2.

```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si
```

Optional cleanup after install:

```bash
rm -rf /tmp/yay
```

Verify `yay` is installed:

```bash
yay --version
```

## 2) Install `chezmoi` using `yay`

Install chezmoi from the AUR:

```bash
yay -S --needed chezmoi
```

Verify installation:

```bash
chezmoi --version
```

## 3) Initialize `chezmoi` with this dotfiles repo

Run:

```bash
chezmoi init https://github.com/iop098321qwe/dotfiles-arch.git
```

This clones the source state into `~/.local/share/chezmoi` and prepares
chezmoi to manage files in your home directory.

## 4) Preview what will change

Before writing files, review pending changes:

```bash
chezmoi status
chezmoi diff
```

You can also inspect how a specific file will render:

```bash
chezmoi cat ~/.bashrc
```

## 5) Apply the dotfiles

Apply all managed files:

```bash
chezmoi apply
```

This writes the dotfiles to your home directory and runs any relevant
`run_once_`, `run_onchange_`, and `run_update_` scripts in `.chezmoiscripts/`
based on chezmoi's script rules.

## 6) Keep your dotfiles up to date

To pull the latest changes from the repo and re-apply them:

```bash
chezmoi update
```

## Optional: One-Command Bootstrap

If you are setting up a fresh machine and want initialization + apply in one
command:

```bash
chezmoi init --apply https://github.com/iop098321qwe/dotfiles-arch.git
```

## Troubleshooting

- If a command fails, run `chezmoi doctor` to check environment issues.
- Use verbose output for more detail: `chezmoi -v apply`.
- Re-run `chezmoi diff` before applying if you want to confirm changes again.

