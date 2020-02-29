if builtin command -v ranger > /dev/null; then
  # ranger の設定ファイルがなかったら持って来る
  if [ ! -e "$HOME/.config/ranger/README.rst" ]; then
    if [ -d "$HOME/.config/ranger/" ]; then
      rm -rf $HOME/.config/ranger/
    fi
    git clone git@github.com:qh73xe/rangerrc.git  $HOME/.config/ranger
    if [ $DISTRIBUTION = "ubuntu" ]; then
      sh $HOME/.config/ranger/install.ubuntu.sh
    fi
  fi

  # ranger の多重起動を防止
  RANGER_CMD=$(which ranger)
  function ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
      ime_off # ranger 使用時には IME を取り消す
      $RANGER_CMD $@
    else
      exit
    fi
  }

  # 各種エイリアス設定
  alias config='ranger $HOME/.config'
  alias vimrc='ranger $HOME/.config/nvim'
  alias zshrc='ranger $HOME/.config/zsh'
  alias tmuxrc='ranger $HOME/.config/tmux'
  alias rangerrc='ranger $HOME/.config/ranger'
fi
