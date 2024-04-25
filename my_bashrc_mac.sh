# https://medium.com/@json_singh/ubuntu-like-terminal-in-mac-bash-9afe37b09aa

# for brew so this command works; echo $(brew --prefix)
# export PATH="/opt/homebrew/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# postgresql@15 is keg-only, which means it was not symlinked into /opt/homebrew,
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Enable colors in bash
export CLICOLOR=1
export LSCOLORS=GxBxCxDxexegedabagaced

# for bash completion; brew install bash-completion@2
# brew search completion
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"


# https://unix.stackexchange.com/a/228/150895
function pgrep() {
    ps aux | grep $1 | grep -v grep
}
function pkill() {
    local pid
    pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
    kill -9 $pid
    echo -n "Killed $1 (process $pid)"
}

function _notify_send(){
    echo "display notification params $1 param2 $2"
    osascript -e "display notification \"$2\" with title \"$1\"";
}
alias notify-send="_notify_send"
