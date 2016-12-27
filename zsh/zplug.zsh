zplug "b4b4r07/enhancd", at:v2.2.1, use:init.sh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

zplug "creationix/nvm", use:nvm.sh
zplug "joelthelion/autojump", as:command, use:bin/autojump

## aliases
zplug "sotarok/dotfiles", use:zsh/aliases
zplug "~/.zshaliases", from:local

zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh

zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"

zplug "jimeh/zsh-peco-history"

#case "${OSTYPE}" in
#darwin*)
#    zplug "plugins/osx", from:oh-my-zsh
#    ;;
#esac
