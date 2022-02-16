# https://medium.com/@json_singh/ubuntu-like-terminal-in-mac-bash-9afe37b09aa

# for brew so this command works; echo $(brew --prefix)
export PATH="/opt/homebrew/bin:$PATH"

# Enable colors in bash
export CLICOLOR=1
export LSCOLORS=GxBxCxDxexegedabagaced

# for bash completion; brew install bash-completion@2
# brew search completion
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
