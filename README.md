# Dotfiles

This repository contains my personal development environment configuration.  
It automates the setup of my terminal, shell, Git, SSH, and essential tools on macOS.

---

## Goals

- Use **zsh** as my main shell.
- Have a clean, minimal prompt powered by **Starship**.
- Manage zsh plugins with **Antidote**.
- Install and configure all core dependencies in one step.
- Keep all my customizations backed up and versioned.

---

## What’s Included

- **Host**: macOS
- **Terminal**: iTerm2
- **Shell**: zsh
- **Dependencies** (installed automatically):
    - [Homebrew](https://brew.sh/)
    - git
    - gnupg
    - thefuck
    - goto
    - [fnm](https://github.com/Schniz/fnm) (Fast Node Manager)
    - starship (prompt)
- **Dotfiles**: `.zshrc`, `.zsh_aliases`, `.zsh_plugins.txt`, `starship.toml`
- **GPG + SSH**: configuration for commit signing and GitHub access

---

## Installation

Clone this repo and run the installer:

```bash
git clone https://github.com/ninehd/dotfiles.git ~/dev/github/dotfiles
cd ~/dev/github/dotfiles
./install.sh