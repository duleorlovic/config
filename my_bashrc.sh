# when there is "echo" in bashrc then scp file this mashine produces error
# "scp: Ensure the remote shell produces no output for non-interactive sessions"
# so we need to check if it is interactive or not, so scp is not broken
if [[ $- == *i* ]]; then
  echo "hello from my_bashrc.sh in interactive shell"
fi

function is_mac_os {
  if [ "$(uname)" == "Darwin" ]; then
    # 0 is true
    return 0
  else
    # 1 is false
    return 1
  fi
}
# we need to export so it is available in subshell, eg vim :!
export -f is_mac_os

MY_FILES=(
  ~/config/keys/my_keys.sh
  ~/config/bashrc/get_current_viewport.sh
  ~/config/bashrc/ionic.sh
  ~/config/bashrc/rails.sh
  ~/config/bashrc/arduino.sh
  ~/config/bashrc/common_functions.sh
)

for my_file in ${MY_FILES[*]}; do
  if [ -f $my_file ]; then
    source $my_file
  fi
done

# if [ "`pgrep dbus-monitor`" == "" ];then
#   echo Starting monitor_lock_hooks
#   /home/orlovic/config/bashrc/monitor_lock_hooks.sh
# fi

export EDITOR=vim

# Add Android SDK tools to PATH
export ANDROID_HOME=/media/orlovic/bf12a7e5-a5d4-4532-8612-a3984f90b56c/shared/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_SDK_HOME=$ANDROID_HOME
# issue with unable to load driver https://stackoverflow.com/questions/35911302/cannot-launch-emulator-on-linux-ubuntu-15-10/36625175#36625175
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
# for emulator command
export PATH="$PATH:$ANDROID_HOME/emulator"
# for android command
export PATH="$PATH:$ANDROID_HOME/tools"
# for adb
export PATH="$PATH:$ANDROID_HOME/platform-tools"
# for genymotion
export PATH="$PATH:$HOME/Programs/genymotion"
# for studio.sh
# export PATH="$PATH:$HOME/Programs/android-studio/bin"
export PATH="$PATH:/media/orlovic/bf12a7e5-a5d4-4532-8612-a3984f90b56c/shared/programs/android-studio/bin"
# for gradle
export PATH="$PATH:$HOME/Programs/gradle/bin"
# for glass
export PATH="$PATH:$HOME/Programs/glass"
# for my scripts
export PATH="$PATH:$HOME/config/bin"
# for pipx installed packages
export PATH="$PATH:$HOME/.local/bin"

export SECRET_KEY_BASE=123asd

function d {
  if [  -z $1 ]
  then
    echo Default is middle value: d 0.5
  fi
  # to find your crtc number use xrandr --verbose, something like HDMI-0, LVDS1
  xrandr --auto
  xrandr --output ${CRTC:DFP1} --brightness ${1:-0.5}
  # when error is xrandr: Need crtc to set gamma on.
  # sudo apt-get install xbackligh
  # xbacklight -dec 2 # or -inc %
}
alias dim=d

# copy line to clipboard
if is_mac_os; then
  # to copy from grep result you can use: grep asd README.md | pbcopy
  bind '"\C-l": "\C-e\C-u pbcopy <<"EOF"\n\C-y\nEOF\n\C-y"'
else
  alias pbcopy="xsel --clipboard"
  # to copy from grep result you can use: grep asd README.md | xclip
  bind '"\C-l": "\C-e\C-u xsel --clipboard <<"EOF"\n\C-y\nEOF\n\C-y"'
fi

function echo_red {
  tput setaf 1
  echo $@
  tput sgr0
}

function echo_and_run {
  echo_red $@
  $@
}

function keys {
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Edit keys for current project, if exists.
    Add -s to source keys instead of edit
    Add -ss to source keys and server script
	HERE_DOC
    return
  fi
  current_path=$(pwd)
  projectName=`basename $current_path`
  if [ -f ~/config/keys/$projectName.sh ];then
    if [ "$1" == "-s" ]; then
      echo_red source ~/config/keys/$projectName.sh
      source ~/config/keys/$projectName.sh
    elif [ "$1" == "-ss" ]; then
      echo_red source ~/config/keys/$projectName.server.sh
      source ~/config/keys/$projectName.server.sh
    else
      echo_red vi ~/config/keys/$projectName.sh
      vi ~/config/keys/$projectName.sh
    fi
  else
    echo_red can not find ~/config/keys/$projectName.sh
  fi
}

function my_keys {
  vi ~/config/keys/my_keys.sh
}

function my_aws_keys {
  vi ~/config/keys/my_aws_keys.sh
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if is_mac_os; then
  # https://www.macinstruct.com/tutorials/how-to-enable-git-tab-autocomplete-on-your-mac/
  if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  fi
else
  alias g=git
  # https://brbsix.github.io/2015/11/23/perform-tab-completion-for-aliases-in-bash/
  _completion_loader git
  complete -o bashdefault -o default -o nospace -F _git g
fi

alias be='bundle exec'


if [[ $(which aws_completer) ]]; then
  # enable aws completion
  complete -C $(which aws_completer) aws
fi

# http://dokku.viewdocs.io/dokku/community/clients/
alias dokku='$HOME/.dokku/contrib/dokku_client.sh'

alias t=terraform
complete -C $(brew --prefix)/bin/terraform terraform

# add bin to path, but only for project where you  run mkdir -p .git/safe
# this is usefull for rails projects so instead bin/rspec use rspec
export PATH=".git/safe/../../bin:$PATH"

export PATH="~/Programs/bin:$PATH"

# https://github.com/titusfortner/webdrivers
# export PATH="$HOME/.webdrivers:$PATH"

# xsel raise error when DISPLAY is defined
# Invalid MIT-MAGIC-COOKIE-1 keyxsel: Can't open display: (null)
# export DISPLAY=":0.0"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# simplest is to attach current branch name
# export PS1="$PS1\$(parse_git_branch)>"
# echo '$PS1'
# \[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ 
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\$(parse_git_branch)\[\033[00m\]\$ "

if is_mac_os; then
  source ~/config/bashrc/mac_scripts/mac_window_shortcuts.sh
  source ~/config/my_bashrc_mac.sh
  eval "$(brew shellenv)"
else
  source ~/config/bashrc/window_shortcuts.sh
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if command -v "pyenv"; then
  # instead of manually adding python3 packages to path, use pyenv
  # export PATH="$(python3 -m site --user-base)/bin:${PATH}"
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# add globally installed packages `yarn add global ...` to PATH
export PATH="$PATH:$(yarn global bin)"

# history size
export HISTFILESIZE=1000000
export HISTSIZE=1000000

# error while running tests: Chromedriver / Capybara Too many open files - socket(2) for "127.0.0.1" port 9518
# https://stackoverflow.com/a/61892983/287166
ulimit -Sn 10240

# https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_DEFAULT_OPTS="--bind ctrl-j:accept --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"

# used for: ssh $LAN.123 instead of long: ssh 192.168.88.123
export LAN=192.168.88


function bbrew() {
 ssh brew@localhost 'bash  --login -c "export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH && brew '"$@"'"'
 }
