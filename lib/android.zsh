# if [ -e "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home" ]; then
#   export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
# fi
export ANDROID_HOME=$HOME/Library/Android/sdk
if [ -e "$ANDROID_HOME" ]; then
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/platform-tools
fi
