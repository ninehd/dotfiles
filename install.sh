#!/usr/bin/env bash
set -euo pipefail

echo "=== Homebrew ==="
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Load Homebrew environment into this shell
  eval "$(/opt/homebrew/bin/brew shellenv)" || true
else
  echo "Homebrew is already installed. Updating..."
  brew update
  eval "$(/opt/homebrew/bin/brew shellenv)" || true
fi

install_or_upgrade() {
  local pkg="$1"
  if ! brew list --formula --versions "$pkg" &>/dev/null; then
    echo "Installing $pkg..."
    brew install "$pkg"
  else
    echo "Upgrading $pkg..."
    brew upgrade "$pkg" || true
  fi
}

echo "=== Base packages ==="
for pkg in git gnupg thefuck goto fnm starship; do
  install_or_upgrade "$pkg"
done

echo "=== Configure fnm (Node.js) ==="
# If no Node.js version is installed via fnm, install latest LTS and set as default
if ! fnm ls | grep -q "v"; then
  echo "Installing latest Node.js LTS via fnm..."
  fnm install --lts
  fnm default "$(fnm ls --lts | tail -1)"
fi

# --- Git configuration ---
email="13874932+ninehd@users.noreply.github.com"
username="ninehd"
gpgkeyid="245CACAE2F1F447E"

echo "=== Git configuration ==="
git config --global user.email "$email"
git config --global user.name "$username"
git config --global user.signingkey "$gpgkeyid"
git config --global commit.gpgsign true
git config --global core.pager /usr/bin/less
git config --global core.excludesfile "$HOME/.gitignore"

# --- SSH key setup ---
SSH_KEY="$HOME/.ssh/id_rsa"

if [ ! -f "$SSH_KEY" ]; then
  echo "Generating new SSH key..."
  mkdir -p "$HOME/.ssh"
  ssh-keygen -t rsa -b 4096 -C "$email" -f "$SSH_KEY" -N ""
else
  echo "SSH key already exists at $SSH_KEY"
fi

echo "Starting ssh-agent..."
eval "$(ssh-agent -s)" >/dev/null
ssh-add "$SSH_KEY" || true

echo "=== Your public key (add this to GitHub) ==="
cat "$SSH_KEY.pub"

echo "=== Antidote (zsh plugin manager) ==="
ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"
if [ ! -d "$ANTIDOTE_DIR" ]; then
  echo "Installing Antidote..."
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
else
  echo "Antidote already present. Updating..."
  git -C "$ANTIDOTE_DIR" pull --ff-only || true
fi

echo "=== Symlinks for dotfiles ==="
DOTFILES_DIR="$HOME/dev/github/dotfiles"
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

link_file() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✓ $dest already points to $src"
  else
    echo "Linking $dest → $src"
    ln -sf "$src" "$dest"
  fi
}

link_file "$DOTFILES_DIR/.zsh_aliases"      "$HOME/.zsh_aliases"
link_file "$DOTFILES_DIR/.zshrc"            "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.gitignore"        "$HOME/.gitignore"
link_file "$DOTFILES_DIR/.zsh_plugins.txt"  "$HOME/.zsh_plugins.txt"
link_file "$DOTFILES_DIR/starship.toml"     "$CONFIG_DIR/starship.toml"
link_file "$DOTFILES_DIR/nvim"              "$CONFIG_DIR/nvim"

echo "=== Done ==="
echo "Homebrew, base tools, Antidote, Starship and fnm are ready."
echo 'Make sure you have this in your ~/.zshrc:  eval "$(fnm env --use-on-cd --shell zsh)"'
echo 'Then reload your shell:  source ~/.zshrc'