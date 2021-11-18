#!/bin/bash -x
#
# This is used to open windows on specific keyboard shortcuts
# http://blog.trk.in.rs/2016/02/01/bash/#tocAnchor-1-3
# https://github.com/jordansissel/xdotool
# sudo apt-get install xdotool chromium
# xwininfo
# xdotool search --classname myclass
# xprop
# wmctrl
# bash -l  # rvm asks for login

upper()
{
  projectPath=${1-$(pwd)}
  folderName=`basename $projectPath`
  port=300`expr $(get_current_viewport) + 1`
  url=http://localhost:$port

  s $projectPath j 212x30+0-0

  s $projectPath k 120x24+830+45 "pwd; \
    echo k"

  win_width=212 # `expr $(monitor_size) / 36` # 3840 / 36     7200 / 36 = 200
  s $projectPath semicolon ${win_width}x24-0+0 "git pull --ff-only; \
    if [ -f ~/config/keys/$folderName.server.sh ];then
      echo source ~/config/keys/$folderName.server.sh
      source ~/config/keys/$folderName.server.sh;
    fi;
    rake db:create;
    rake db:migrate;
    rails s -b 0.0.0.0 -p $port"

  s ~/jekyll/blog l 80x24+1189+0 # right: 80x24-0+100 # 80x24+1250+100

  start_browser /snap/bin/firefox h $url "Mozilla Firefox"
  start_browser chromium u $url Google 0,1900,0,-1,-1
}

under()
{
  projectPath=${1-$(pwd)}
  s $projectPath m  100x24+700-100 "echo m"
  s $projectPath comma  100x24+900-50 "echo ,"
  s $projectPath dot  100x24-1100-0 "echo ."
  win_width=212 # `expr $(monitor_size) / 36` # 7200 / 36 = 200
  s $projectPath slash  ${win_width}x35-0-0 "echo /"
}

all()
{
  under ${1}
  upper ${1}
}

start_browser()
{
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function starts browser and assign shortcut keys ALT+hjkl semicolon
        with help of System Settings-Keyboard-Shortcuts and command xdotool
    example usage: start_browser h http://localhost:3000 google-chrome Google 0,400,100,-1,-1
    browser_command: firefox google-chrome chromium
    key: default is h, could be h,j,k,l,semicolon... you can add any shortcut
    url: default is http://localhost:3000
    browser_name_in_wmctrl: "Mozilla Firefox" (coould be "Google")
    position: 0,0,0,-1,-1  first is 0, than distance from left and top and width,height
	HERE_DOC
    return
  fi
  browser_command=${1-/snap/bin/firefox}
  browser_key=${2-h}
  port=300`expr $(get_current_viewport) + 1`
  url=${3-http://localhost:$port}
  browser_name_in_wmctrl=${4-"Mozilla Firefox"}
  position=${5-"0,0,0,-1,-1"}
  browser_class=vp_$(get_current_viewport)_class_$browser_key

  echo_red opening $browser_command at url=$url with position=$position
  # google-chrome $url --new-window --auto-open-devtools-for-tabs &
  # auto-open-devtools-for-tabs will open for each new tab :(
  # chromium $url --new-window & # --new-window option is not in man
  $browser_command --new-window $url &
  attempts=0
  browser_window_id=
  # browser_name_in_wmctrl=${url#*//} # remove http://
  echo trying to find browser_name_in_wmctrl=$browser_name_in_wmctrl \
       if windows with same name exists, last one will be used
  sleep 3 # give some time to boot up
  browser_window_id=`wmctrl -l | grep "$browser_name_in_wmctrl" | awk '{print $1}' | tail -n1`
  if [ -n "$browser_window_id" ]
  then
    echo found browser=$browser_name_in_wmctrl window_id=$browser_window_id and mark \
         browser_class=$browser_class
    wmctrl -e $position -i -r $browser_window_id # move
    xprop -f WM_CLASS 8s -set WM_CLASS $browser_class -id $browser_window_id

    # developer_tools_key=u
    # dt_class=vp_$(get_current_viewport)_class_$developer_tools_key
    # echo open developer_tools_key=$developer_tools_key dt_class=$dt_class, if same window name exists than first is used
    # xdotool search --name "$browser_name_in_wmctrl" windowactivate windowfocus key F12
    # # xdotool search --name $url getwindowpid # pid is different than window_id
    # attempts=0
    # dt_window_id=
    # while [ $attempts -lt 20 ] && [ -z "$dt_window_id" ]
    # do
    #   printf '.'
    #   sleep 1
    #   dt_window_id=`wmctrl -l | grep 'Developer Tools' | awk '{print $1}' | tail -n1`
    #   attempts=$[$attempts+1]
    # done
    # if [ -n "$dt_window_id" ]
    # then
    #   echo mark dt_window_id=$dt_window_id dt_class=$dt_class
    #   xprop -f WM_CLASS 8s -set WM_CLASS $dt_class -id $dt_window_id
    # fi
  else
    echo can not find $url
  fi
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
    command: default is 'vim'. Don't end with ; Multuple commands with ; or &&
	HERE_DOC
    return
  fi
  folder=${1-.}
  folderName=`basename $folder`
  class=vp_$(get_current_viewport)_class_${2-j}
  geometry=${3-300x30+0-0}
  command=${4-vim}
  echo class=$class folder=$folder geometry=$geometry and \
    run command=$command
  last_command=${command##*;}
  echo put last_command=$last_command in bash history so we have it when we stop the proccess
  # http://stackoverflow.com/questions/3162385/how-to-split-a-string-in-shell-and-get-the-last-field
  echo_and_run history -s $last_command
  history -a
  gnome-terminal --geometry=$geometry -- bash --login -c "\
    cd $folder;\
    xprop -f WM_CLASS 8s -set WM_CLASS $class -id \$(xdotool getwindowfocus);\
    if [ -f ~/config/keys/$folderName.sh ];then
      echo source ~/config/keys/$folderName.sh
      source ~/config/keys/$folderName.sh;
    fi;
    $command;\
    bash -l"
  sleep 1
}

qall()
{
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this is quit function for all windows
	HERE_DOC
    return
  fi
  # TODO: Maximize all windows, tried with: wmctrl -k off
  # it only Show desktop (minimized wins stays minimized)
  # this will activate in all screens
  # xdotool search --onlyvisible --name '.*'  windowactivate %@
  # so we need to iterate to all possible classes (other terminal windows
  # without those classes will stay minimized)
  keys=(j k l colon semicolon h u m comma dot slash)
  for key in "${keys[@]}"
  do
    class_name=vp_$(get_current_viewport)_class_$key
    xdotool search --onlyvisible --classname $class_name windowactivate %@
  done

  xdotool getactivewindow windowminimize # this is for debug

  # TODO: find browser only on current desktop, tryed: --onlyvisibe --desktop 1
  # echo windowkill Chrome
  # xdotool search Chrom windowkill
  sleep 1

  # I disabled Return to use Ctrl+j in vim
  vim_return=ctrl+j
  vim_colon=colon
  last_name=start_name
  last_pid=start_pid
  retry=0
  # same window name calculate as retry so use high retry
  max_retries=2
  sleep_after_close=0.3
  while true; do
    name=`xdotool getactivewindow getwindowname`
    pid=`xdotool getactivewindow getwindowfocus`
    echo_red "found name=$name pid=$pid"
    echo_red "last_name=$last_name last_pid=$last_pid"
    case $name in
      *VIM) echo VIM window
        echo q a vim_return
        xdotool key Escape $vim_colon q a $vim_return
        sleep $sleep_after_close
        # xdotool key e x i t $vim_return
        # sleep $sleep_after_close
        ;;
      *) echo unknown $name
        # echo esc Return
        # xdotool key Escape Return
        # sleep 2.3
        # echo q Return
        echo exit Return
        xdotool key e x i t Return
        sleep $sleep_after_close
        xdotool key q Return
        sleep $sleep_after_close
    esac
    # last window is usually Desktop or Terminal with some running proccess
    if [ "$pid" == "$last_pid" ] ;then
      if [ $retry -gt $max_retries ];then
        alert "bump to the same window pid=$pid so break this"
        break
      else
        echo "bump to the same window pid=$pid retry=$retry minimize and try again"
        xdotool getactivewindow windowminimize
      fi
      retry=$[$retry+1]
    fi
    last_name=$name
    last_pid=$pid
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
    elif [ "$char" == ":" ]; then
      key="colon"
    elif [ "$char" == ";" ]; then
      key="semicolon"
    elif [ "$char" == "," ]; then
      key="comma"
    elif [ "$char" == "/" ]; then
      key="slash"
    else
      key=$char
    fi
    xprop -f WM_CLASS 8s -set WM_CLASS vp_$(get_current_viewport)_class_$key -id `xdotool getwindowfocus`
    echo " ... thanks. shortcut is ALT+$key for window WM_CLASS vp_$(get_current_viewport)_class_$key"
  else
    echo click on windows to bind to key $key
    xprop -f WM_CLASS 8s -set WM_CLASS vp_$(get_current_viewport)_class_$key
    echo thanks. shortcut is ALT+$key for window WM_CLASS vp_$(get_current_viewport)_class_$key
    echo multiple windows with the same classname toggles between them
  fi
}

monitor_size() {
  size=`wmctrl -d | head -n1 | cut -d'x' -f1 | sed -e 's/[^0-9 ]//g'`
  # on two monitors it is 7200
  echo $size
}
