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
  export TMUX_POWERLINE_SEG_WEATHER_LOCATION="26237038"
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

  zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
  zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
  zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
  zplug "mollifier/anyframe"
  

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
  zplug "yonchu/zsh-python-prompt"
  zplug "mafredri/zsh-async"
  zplug "sindresorhus/pure"

  # gibo
  zplug 'simonwhitaker/gibo', use:'gibo', as:command

  # Install plugins if there are pl
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load --verbose

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
  alias cdg='cd-gitroot'

  hash -d proj=~/Documents/proj
  hash -d prod=~/Documents/prod

  # ===================================================
  # 開発環境
  # ===================================================
  # anyframeの設定
  setopt AUTO_PUSHD # cdしたら自動でディレクトリスタックする
  setopt pushd_ignore_dups # 同じディレクトリは追加しない
  DIRSTACKSIZE=100 # スタックサイズ
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ":anyframe:selector:" use peco
  bindkey '^Z' anyframe-widget-cdr
  bindkey '^R' anyframe-widget-put-history
  # pyenv
  if [ -e "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
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


# コマンド実行後フック
autoload -Uz add-zsh-hook
add-zsh-hook preexec ime_off
add-zsh-hook precmd ime_off

ime_off() {
  #  コマンド実行後に IME を off にする.
  case ${OSTYPE} in
    darwin*)
      ;;
    linux*)
      if [ $(ibus engine) != "xkb:jp::jpn" ]; then
        ibus engine xkb:jp::jpn
      fi
      ;;
  esac
}
