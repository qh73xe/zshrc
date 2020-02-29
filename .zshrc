# ====================================
# zsh 設定
# ====================================

# 外部設定ファイルの読み込み関数の作成
export ZSH_CONF_DIR="$HOME/.config/zsh"
export ZSH_LIB_DIR="$HOME/.config/zsh/lib"
function loadlib() {
    lib=${1:?"You have to specify a library file"}
    if [ -f "$lib" ]; then
        . "$lib"
    else
        echo "$lib is not found"
    fi
}

# 基本設定ファイルの呼出
loadlib $ZSH_CONF_DIR/ostype.zsh
loadlib $ZSH_CONF_DIR/init.zsh
loadlib $ZSH_CONF_DIR/install_tool.zsh

# ツール別設定ファイルの呼出
if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
    loadlib $ZSH_LIB_DIR/tmux.zsh
else
  loadlib $ZSH_LIB_DIR/terminology.zsh
  loadlib $ZSH_LIB_DIR/latexmk.zsh
  loadlib $ZSH_LIB_DIR/slack-term.zsh
  loadlib $ZSH_LIB_DIR/nvim.zsh
  loadlib $ZSH_LIB_DIR/ranger.zsh
  loadlib $ZSH_LIB_DIR/direnv.zsh
  loadlib $ZSH_LIB_DIR/python.zsh
  loadlib $ZSH_LIB_DIR/javascript.zsh
  loadlib $ZSH_LIB_DIR/ruby.zsh
  loadlib $ZSH_LIB_DIR/zplug.zsh
fi
