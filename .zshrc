### --- GPG ---
export GPG_TTY=$(tty)

### --- PATH ---
# Base paths
export PATH="$HOME/bin:/opt/homebrew/bin:$HOME/dev/flutter/bin:/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/emulator:$PATH"
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

### --- Antidote (plugin manager) ---
source ~/.antidote/antidote.zsh
ZPLUG_FILE="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"
ZPLUG_CACHE="${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"

if [[ ! -f "$ZPLUG_CACHE" || "$ZPLUG_FILE" -nt "$ZPLUG_CACHE" ]]; then
  antidote bundle < "$ZPLUG_FILE" >| "$ZPLUG_CACHE"
fi
source "$ZPLUG_CACHE"

### --- Aliases ---
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

### --- Environnement perso ---
# Variables locales, si tu veux éviter d’éditer ce fichier directement
[ -f ~/.env ] && source ~/.env

# Git auto-fetch interval (en secondes)
export GIT_AUTO_FETCH_INTERVAL=1200

### --- fzf ---
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND="find ."

### --- goto (bash completion) ---
autoload -Uz bashcompinit && bashcompinit
source "$(brew --prefix)/etc/bash_completion.d/goto.sh"

### --- fzf-tab settings ---
zstyle ':completion:*:git-checkout:*' sort false
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind='tab:accept'
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

### --- fnm (Fast Node Manager) ---
eval "$(fnm env --use-on-cd --shell zsh)"

### --- TheFuck ---
eval "$(thefuck --alias)"
bindkey -s '\e\e' 'fuck\n'

### --- Starship ---
eval "$(starship init zsh)"