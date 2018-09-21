# ========================================================
# 設定用の便利関数
# ========================================================
install_if_not_exist () {
  case ${OSTYPE} in
      darwin*)
          install_cmd="brew"
          ;;
      linux*)
          install_cmd="sudo apt"
          ;;
  esac
  if ! builtin command -v $1 > /dev/null;
    then
    sh -c "$install_cmd install $1"
  fi
}

load_if_exist () {
  if [[ -s $1 ]]; then
    source $1
  fi
}

# 種々欲しいコマンドのインストール
# ========================================================
install_if_not_exist curl
install_if_not_exist git
install_if_not_exist tmux

if [[ -z "$TMUX" && ! -z "$PS1" ]];
  # ===================================================
  # tmux の呼出し
  # ===================================================
  then
  export TERM=xterm-256color
  tmux
else
  # ===================================================
  # zplug
  # ===================================================
  if [ ! -e "$HOME/.zplug" ]; then
    curl -sL --proto-redir -all,https \
    https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  fi
  export ZPLUG_HOME="$HOME/.zplug"
  source ~/.zplug/init.zsh
  # 情報追加
  zplug "tcnksm/docker-alias", use:zshrc
  zplug "plugins/git",   from:oh-my-zsh

  # シンタックスハイライト
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "chrissicool/zsh-256color"
  zplug "ascii-soup/zsh-url-highlighter"

  # 移動支援
  zplug "mollifier/cd-gitroot"

  # 補完
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "tarruda/zsh-fuzzy-match"

  # プロンプト表示
  zplug "mafredri/zsh-async"
  zplug "sindresorhus/pure"
  zplug "yonchu/zsh-python-prompt"

  # gibo
  zplug 'simonwhitaker/gibo', use:'gibo', as:command

  # Install plugins if there are pl
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
    zplug load --verbose
  else
    zplug load
  fi

  # ===================================================
  # 言語設定
  # ===================================================
  export LANG=ja_JP.UTF-8
  export LANGUAGE=en_US.UTF-8
  export LC_ALL=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8
  export LANG=en_US.UTF-8

  # ===================================================
  # エイリアス
  # ===================================================
  alias vi='nvim'
  alias vim='nvim'

  hash -d proj=~/Documents/proj
  hash -d prod=~/Documents/prod

  # ===================================================
  # 開発環境
  # ===================================================

  # pyenv
  if [ -e "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv shell --unset
  fi

  # node
  if [ -e "$HOME/.npm-global/bin" ]; then
    export PATH="$HOME/.npm-global/bin:$PATH"
  fi

  # direnv
  DIRENV=$(pgrep -f -l 'evince' | wc -l)
  if [ "${DIRENV}" -eq  0 ]; then
    eval "$(direnv hook zsh)"
  fi
fi
