# load arduino-cli bash completion
source ~/config/bashrc/arduino-cli.sh

# https://github.com/sudar/Arduino-Makefile/blob/master/Arduino.mk#L58
if is_mac_os; then
  export ARDMK_DIR=`brew --prefix arduino-mk`
  export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
  export AVR_TOOLS_DIR=$ARDUINO_DIR/hardware/tools/avr
else
  export ARDMK_DIR=/usr/share/arduino/
  export ARDUINO_DIR=/usr/share/arduino
  export AVR_TOOLS_DIR=/usr
fi

exit_on_error() {
    exit_code=$1
    last_command=${@:2}
    if [ $exit_code -ne 0 ]; then
        >&2 echo "\"${last_command}\" command failed with exit code ${exit_code}."
        exit $exit_code
    fi
}
arduino-cli-upload() {
  if [ "$1" == "-h" ] || [ "$1" == "" ]; then
    cat <<-HERE_DOC
    Hi, you can use me to compile, upload and open serial port
        arduino-cli-upload fqbn port
        arduino-cli-upload esp8266:esp8266:generic /dev/cu.usbserial-13320
	HERE_DOC
    return
  fi
  fqbn=${1}
  port=${2}
  arduino-cli compile --fqbn $fqbn || return 1
  arduino-cli upload --fqbn $fqbn -p $port || return 1
  # sleep 3 # sleep 2 does not work
  # arduino-cli monitor -p $port
}
