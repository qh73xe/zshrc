export ANDROID_HOME=$HOME/Library/Android/sdk
if [ -e "$ANDROID_HOME" ]; then
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
fi
