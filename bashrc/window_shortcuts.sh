#!/bin/bash -x
# http://blog.trk.in.rs/2016/02/01/bash/#tocAnchor-1-3
# sudo apt-get install xdotool chromium-browser
# xwininfo
# xdotool search --classname
# xprop
# wmctrl
# bash -l  # rvm asks for login

DEFALT_PROJECT=~/rails/race-time-sampling

# http://askubuntu.com/questions/41093/is-there-a-command-to-go-a-specific-workspace
# http://stackoverflow.com/questions/17336915/return-value-in-bash-script
# use with vp_number=$(get_current_viewport)
get_current_viewport()
{
  SIZE=`wmctrl -d | awk '{print $6}'`
  # http://stackoverflow.com/questions/23663963/split-string-into-multiple-variables-in-bash
  IFS=',' read vp_width vp_height <<< $SIZE
  if [ "$vp_width" = "0" ] && [ "$vp_height" = "0" ]; then
    echo 1
  else
    if [ "$vp_height" = "0" ]; then
      echo 2
    else
      if [ "$vp_width" = "0" ]; then
        echo 3
      else
        echo 4
      fi
    fi
  fi
}

a()
{
  project=${1-$DEFALT_PROJECT}

  s $project j

  s $project k 120x24-10+200 "echo 'run here'"

  s $project l 100x24-0+0 "git pull && rake db:migrate && rails s"

  s ~/jekyll/blog semicolon 80x24-0+100

  echo opening browser preview and bint to h
  chromium-browser http://localhost:3000 --new-window & # this --new-window option is not in man file
  sleep 1
  wmctrl -e 0,0,0,-1,-1 -r Chromium # move
  xprop -f WM_CLASS 8s -set WM_CLASS vp_$(get_current_viewport)_class_h -id `wmctrl -l | grep Chromium | awk '{print $1}' | tail -n1`
}

s()
{
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this is start function for windows with shortcut keys ALT+hjkl semicolon
        with help of System Settings-Keyboard-Shortcuts and command
        xdotool search --classname vp_$(get_current_viewport)_class_j windowactivate
    example usage: s folder key geometry command
    folder: default is .
    key: default is i, could be h,j,k,l,semicolon... you can add any shortcut
    geometry: chars x rows x pixels_from_left x pixels_from_top
              if negative pixels than it is pixes_from_right/bottom
              default is 300x30+0-0
    command: default is 'vim .'. Don't end with ; Multuple commands with ; or &&
	HERE_DOC
    return
  fi
  folder=${1-.}
  class=vp_$(get_current_viewport)_class_${2-j}
  geometry=${3-300x30+0-0}
  command=${4-vim .}
  echo opening editor in $folder and bind to $class and set size $geometry and \
    run command $command
  gnome-terminal --geometry=$geometry -x bash --login -c "\
    cd $folder;\
    xprop -f WM_CLASS 8s -set WM_CLASS $class -id \$(xdotool getwindowfocus);\
    $command;\
    bash -l"
  sleep 0.5
}

qa()
{
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this is quit function for all windows
	HERE_DOC
    return
  fi
  xdotool getactivewindow windowminimize
  echo windowkill Chrome
  xdotool search Chromium windowkill
  xdotool search "Google Chrome" windowkill
  last_name=start
  while true; do
    name=`xdotool getactivewindow getwindowname`
    echo found name=$name
    echo found last_name=$last_name
    if [ "$name" == "$last_name" ];then
      echo bump to the same window... break
      break
    fi
    case $name in
      *VIM) echo VIM window
        xdotool key Escape colon q a Return
        sleep 0.3
        xdotool key e x i t Return
        sleep 0.3
        ;;
      *) echo unknown $name
        last_name=$name
        echo esc return
        xdotool key Escape Return
        sleep 0.3
        echo q return
        xdotool key q Return
        sleep 0.3
        echo exit return
        xdotool key e x i t Return
        sleep 0.3
    esac
  done
}

b()
{
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, bind windows to specifix key.
      b h # bind ALT+h to the mouse selected window
      b # bind current window to the prompted key
	HERE_DOC
    return
  fi
  key=$1
  if [ -z "$key" ];
  then
    echo "please press the character (like h or . or /)"
    read -n1 char
    if [ "$char" == "." ]; then
      key="dot"
    elif [ "$char" == ";" ]; then
      key="semicolon"
    elif [ "$char" == "," ]; then
      key="colon"
    elif [ "$char" == "/" ]; then
      key="slash"
    else
      key=$char
    fi
    xprop -f WM_CLASS 8s -set WM_CLASS vp_$(get_current_viewport)_class_$key -id `xdotool getwindowfocus`
    echo " ... thanks. shortcut is ALT+$key"
  else
    echo click on windows to bind to key $key
    xprop -f WM_CLASS 8s -set WM_CLASS vp_$(get_current_viewport)_class_$key
    echo thanks. shortcut is ALT+$key
    echo multiple windows with the same classname toggles between them
  fi
}
