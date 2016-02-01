#/bin/bash -x

# xwininfo
# xdotool search --classname
# xprop
# wm
# bash -l  # rvm asks for login

DEFALT_PROJECT=~/rails/race-time-sampling

a()
{
  project=${1-$DEFALT_PROJECT}

  s $project

  s $project k 120x24-10+200 "echo 'run here'"

  s $project l 80x24-0+0 "git pull && rake db:migrate && rails s"

  s ~/jekyll/blog semicolon 80x24-400+100

  echo opening browser preview and bint to class_h
  chromium-browser http://localhost:3000 &
  sleep 1
  wmctrl -e 0,0,0,-1,-1 -r Chromium
  xprop -f WM_CLASS 8s -set WM_CLASS class_h -id `wmctrl -l | grep Chromium | awk '{print $1}'`
}

s()
{
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this is start function for windows with shortcut keys ALT+hjkl
        with help of System Settings-Keyboard-Shortcuts and command
        xdotool search --classname class_j windowactivate
    example usage: s folder key geometry command
    folder: default is .
    key: default is j, could be h,j,k,l,semicolon... you can add any shortcut
    geometry: chars x rows x pixels_from_left x pixels_from_top
              if negative pixels than it is pixes_from_right/bottom
              default is 300x30+0-0
    command: default is 'vim .'. Don't end with ; Multuple commands with ; or &&
	HERE_DOC
    return
  fi
  folder=${1-.}
  class=class_${2-j}
  geometry=${3-300x30+0-0}
  command=${4-vim .}
  echo opening editor in $folder and bing to $class and set size $geometry and \
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

bind_to_key()
{
  key=$1
  if [ -z "$key" ];
  then
    echo please provide parameter shortcut_key
    echo example usage: bind_to_key j, bind_to_key_semicolon
  else
    echo click on windows to bind to key class_$key
    xprop -f WM_CLASS 8s -set WM_CLASS class_$key
    echo thanks. shortcut is ALT+$key
    echo multiple windows with the same classname toggles between them
  fi
}
