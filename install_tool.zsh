# アプリケーションを入れる
install_cmd() {
  if [ ${INSTALL_CMD} ]; then
    if builtin command -v $1 > /dev/null; then
    else
      echo "$1 is not found."
      zsh -c "${INSTALL_CMD} $1"
    fi
  fi
}

# ===================================
# 必要ライブラリの導入
# ===================================
install_cmd tmux
install_cmd git
install_cmd nvim
install_cmd direnv
install_cmd xsel
install_cmd zfz

# cli util
install_cmd ranger
install_cmd cmus
install_cmd latexmk
install_cmd jq

# lint
install_cmd shellcheck
install_cmd chktex

# nvim
install_cmd global
install_cmd ctags
install_cmd cmigemo

# ranger
install_cmd mupdf
install_cmd xdotool


if [ $DISTRIBUTION = "ubuntu" ]; then
  install_cmd terminology
fi
