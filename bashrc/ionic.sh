# /bin/bash -x
#
# Some ionic helpers
#

ionic_publish(){
  if [ -f ~/config/keys/my-release-key.keystore ]
  then
    echo Hi, we are building for android release
    cordova build --release android
    target_file=${1:-platforms/android/build/outputs/apk/android-release-unsigned.apk}
    echo using target_file $target_file
    if [ -f my_app.apk ]
    then
      echo move old my_app.apk to ~/Downloads
      mv my_app.apk ~/Downloads
    fi
    echo it might ask you for a password to use your key
    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/config/keys/my-release-key.keystore $target_file alias_name # this will change the file inline
    echo 0
    $ANDROID_HOME/build-tools/21.1.2/zipalign -v 4 $target_file my_app.apk
    echo my_app.apk stored in current folder, use: adb install my_app.apk
    echo 1
  else
    echo You need to create keys in ~/config/keys/my-release-key.keystore
    echo keytool -genkey -v -keystore ~/config/keys/my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
  fi
}

ionic_find_package_name(){
  if [ -z $1 ]
  then
    echo Default apk file is: my_app.apk
  fi
  apk_file=${1:-my_app.apk}
  if [ -f $apk_file ]
  then
    $ANDROID_HOME/build-tools/21.1.2/aapt dump badging $apk_file | sed -n "s/package: name='\(\S*\)'.*/\1/p"

  else
    echo Can not find $apk_file
  fi
}

ionic_log(){
  if [ "$1" == "-h" ]; then
    cat <<-HERE_DOC
    Hi, this function show log from android device connected with usb
	HERE_DOC
    return
  fi
  echo 'starting logcat for device: adb -d logcat | grep "chromium\|Web Console"'
  adb -d logcat | grep 'chromium\|Web Console' # new androids use chromium
}
