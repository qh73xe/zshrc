# Setting environment variables:
export EMSDK=/home/qh73xe/Documents/proj/emsdk
export EM_CONFIG="$EMSDK/.emscripten"
export EM_CACHE="$EMSDK/upstream/emscripten/cache"
export EMSDK_NODE="$EMSDK/node/12.18.1_64bit/bin/node"

# Adding directories to PATH:
export PATH="$EMSDK:$PATH"
export PATH="$EMSDK/upstream/emscripten:$PATH"
export PATH="$EMSDK/node/12.18.1_64bit/bin:$PATH"

source "$EMSDK/emsdk_env.sh"
