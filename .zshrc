# ====================================
# zsh 設定
# ====================================
# 外部設定ファイルの読み込み関数の作成
export ZSH_CONF_DIR="$HOME/.config/zsh"
export ZSH_LIB_DIR="$HOME/.config/zsh/lib"
export ZSH_FUNC_DIR="$HOME/.config/zsh/functions"
export ZSH_BIN_DIR="$HOME/.config/zsh/bin"
DEBUG_MODE=0

function loadlib() {
  lib=${1:?"You have to specify a library file"}
  if [ -f "$lib" ]; then
    rc_log "load $lib"
    . "$lib"
  else
    echo "$lib is not found"
  fi
}

function rc_log() {
  msg=${1:?"You have to specify a msg"}
  if [ $DEBUG_MODE -gt 0 ]; then
    echo "$msg"
  fi
}


# 基本設定ファイルの呼出
loadlib $ZSH_CONF_DIR/ostype.zsh
loadlib $ZSH_CONF_DIR/init.zsh
loadlib $ZSH_CONF_DIR/install_tool.zsh

# ツール別設定ファイルの呼出
loadlib $ZSH_LIB_DIR/terminology.zsh
loadlib $ZSH_LIB_DIR/latexmk.zsh
loadlib $ZSH_LIB_DIR/tmux.zsh
loadlib $ZSH_LIB_DIR/slack-term.zsh
loadlib $ZSH_LIB_DIR/nvim.zsh
loadlib $ZSH_LIB_DIR/ranger.zsh
loadlib $ZSH_LIB_DIR/direnv.zsh
loadlib $ZSH_LIB_DIR/python.zsh
loadlib $ZSH_LIB_DIR/javascript.zsh
loadlib $ZSH_LIB_DIR/ruby.zsh
loadlib $ZSH_LIB_DIR/zplug.zsh

# 補間処理の呼出
fpath=($ZSH_FUNC_DIR $fpath)
compinit
export PATH=$HOME/.nodebrew/current/bin:$PATH
