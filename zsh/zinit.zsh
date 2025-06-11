# Zinit configuration

# Zoxide - modern cd replacement
zinit ice as"command" from"gh-r" mv"zoxide -> zoxide"
zinit light ajeetdsouza/zoxide

# Zsh enhancements
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions

# NVM - Node Version Manager
zinit ice wait lucid
zinit snippet https://github.com/creationix/nvm/blob/master/nvm.sh

# Autojump
zinit ice as"command" pick"bin/autojump"
zinit light wting/autojump

# Local aliases
zinit snippet ~/.dotfiles/zsh/aliases
zinit snippet ~/.zsh/aliases

# Oh-My-Zsh plugins
zinit snippet OMZ::plugins/pip/pip.plugin.zsh
zinit snippet OMZ::plugins/composer/composer.plugin.zsh
zinit snippet OMZ::plugins/npm/npm.plugin.zsh
zinit snippet OMZ::plugins/docker/docker.plugin.zsh
zinit snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

# Binary releases from GitHub
zinit ice as"command" from"gh-r" mv"jq* -> jq"
zinit light jqlang/jq

zinit ice as"command" from"gh-r" mv"ghq* -> ghq"
zinit light x-motemen/ghq

zinit ice as"command" pick"httpstat.py" mv"httpstat.py -> httpstat"
zinit light reorx/httpstat

zinit ice as"command" from"gh-r" mv"peco* -> peco"
zinit light peco/peco

zinit ice as"command" from"gh-r" pick"composer.phar" mv"composer.phar -> composer"
zinit light composer/composer

# Peco history search
zinit light jimeh/zsh-peco-history

# FZF - fuzzy finder with installation script
zinit ice from"gh-r" as"program" pick"$ZPFX/bin/fzf" \
    atclone"./install --bin" atpull"%atclone"
zinit light junegunn/fzf

# FZF shell integration
zinit ice wait lucid
zinit snippet "https://github.com/junegunn/fzf/raw/master/shell/completion.zsh"

zinit ice wait lucid
zinit snippet "https://github.com/junegunn/fzf/raw/master/shell/key-bindings.zsh"

# Load completions
autoload -Uz compinit && compinit

# Zinit completions
zinit cdreplay -q