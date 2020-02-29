# ======================================
# OS 別の設定
# ======================================
case ${OSTYPE} in
  darwin*)
    export INS_CMD="brew install"
    export IMEOFF_CMD=""
    export DISTRIBUTION="darwin"
    ;;
  linux*)
    # ディストリビューション判定
    if builtin command -v hostnamectl > /dev/null; then
        export DISTRIBUTION=$(hostnamectl | grep 'Operating System' | awk '{ print $3 }' | tr '[A-Z]' '[a-z]')
    fi
    # ディストリビューション毎の処理
    export INS_CMD="sudo apt install -y"
    case ${DISTRIBUTION} in
      ubuntu*)
          export INS_CMD="sudo apt install -y"
      ;;
      fedora*)
          export INS_CMD="sudo yum install"
      ;;
    esac
    # キーボードレイアウトからデフォルトの ibus 設定を決定
    if builtin command -v ibus > /dev/null; then
      if [ $(cat /etc/default/keyboard | grep XKBLAYOUT | grep "us") ]; then
        export IMEOFF_CMD="ibus engine xkb:us::eng"
      else
        export IMEOFF_CMD="ibus engine xkb:jp::jpn"
      fi
    else
      export IMEOFF_CMD=""
    fi
    alias open='xdg-open'
    ;;
esac

# ======================================
# OS 別関数設定
# ======================================
# IME をオフにする
ime_off() {
    if [ ${IMEOFF_CMD} ]; then
        zsh -c "${IMEOFF_CMD}"
    fi
}

# アプリケーションを入れる
install_cmd() {
    if [ ${INSTALL_CMD} ]; then
        if builtin command -v $1 > /dev/null; then
        else
           zsh -c "${INSTALL_CMD} $1"
        fi
    fi
}


# コマンド実行後フック
autoload -Uz add-zsh-hook
add-zsh-hook precmd ime_off

# 必要ライブラリの導入
install_cmd tmux
install_cmd git
install_cmd nvim
install_cmd global
install_cmd ctags
install_cmd mupdf
install_cmd xdotool
install_cmd chktex
install_cmd jq
install_cmd shellcheck
install_cmd cmigemo
install_cmd direnv
install_cmd latexmk
install_cmd ranger
if [ $DISTRIBUTION = "ubuntu" ]; then
  install_cmd terminology
fi
