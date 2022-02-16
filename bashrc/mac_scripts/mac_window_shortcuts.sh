#/usr/local/bin/bash
b() {
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
      key="colon"
    elif [ "$char" == "," ]; then
      key="comma"
    elif [ "$char" == "/" ]; then
      key="slash"
    else
      key=$char
    fi
    osascript ~/config/bashrc/mac_scripts/mac_bind_window_to_key.scpt $key
    echo " ... thanks. shortcut is ALT+$key"
  else
    echo focus on window to bind to key $key
    sleep 3
    osascript ~/config/bashrc/mac_scripts/mac_bind_window_to_key.scpt $key
    echo " thanks. shortcut is ALT+$key"
    echo multiple windows with the same classname toggles between them
  fi
}

