# ========================================================
# OS 別の設定
# ========================================================
case ${OSTYPE} in
    darwin*)
        export INSTALL_CMD="brew install"
        export IMEOFF_CMD=""
        export DISTRIBUTION="darwin"
        ;;
    linux*)
        # ディストリビューション判定
        if builtin command -v hostnamectl > /dev/null; then
            export DISTRIBUTION=$(hostnamectl | grep 'Operating System' | awk '{ print $3 }' | tr '[A-Z]' '[a-z]')
        fi

        # ディストリビューション毎の処理
        export INSTALL_CMD="sudo apt install -y"
        case ${DISTRIBUTION} in
            ubuntu*)
                export INSTALL_CMD="sudo apt install -y"
            ;;
            fedora*)
                export INSTALL_CMD="sudo yum install"
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

# ========================================================
# オリジナル関数
# ========================================================

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


# ========================================================
# 必要ライブラリの導入
# ========================================================
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


# ========================================================
# 基本設定
# ========================================================
# 言語設定
export LANG=ja_JP.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# エディタ設定
export EDITOR=nvim

# ディレクトリエイリアス
hash -d proj=~/Documents/proj
hash -d prod=~/Documents/prod

# エイリアス
alias vi='nvim'
alias vim='nvim'
alias lmkp="latexmk -pvc"
alias lmk="latexmk -pdf"
alias slack-term="slack-term --config $HOME/snap/slack-term/current/slack-term.json"

# コマンド実行後フック
autoload -Uz add-zsh-hook
add-zsh-hook precmd ime_off


if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
  alias penv='pipenv'
  alias prun='pipenv run'
  alias prunp='pipenv run python'
  alias pnvim='pipenv run nvim'
  alias pvim='pipenv run nvim'

  # tmux の呼出し
  # --------------------------------------------------------
  export TMUX_POWERLINE_SEG_WEATHER_LOCATION="26237038"
  export TERM=xterm-256color
  tmux
else
  # --------------------------------------------------------
  # zplug
  # --------------------------------------------------------
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

  # シンタックスハイライト
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "chrissicool/zsh-256color"

  # 移動支援
  zplug "mollifier/cd-gitroot"

  # 補完
  zplug "hchbaw/auto-fu.zsh"
  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-history-substring-search"
  zplug "tarruda/zsh-fuzzy-match"

  # プロンプト表示
  zplug "yonchu/zsh-python-prompt"
  zplug "mafredri/zsh-async"
  zplug "modules/prompt", from:prezto

  # gibo
  zplug 'simonwhitaker/gibo', use:'gibo', as:command

  # Install plugins if there are pl
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load

  # mollifier/cd-gitroot
  alias cdg='cd-gitroot'

  # mollifier/anyframe
  setopt AUTO_PUSHD # cdしたら自動でディレクトリスタックする
  setopt pushd_ignore_dups # 同じディレクトリは追加しない
  DIRSTACKSIZE=100 # スタックサイズ
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ":anyframe:selector:" use peco
  bindkey '^Z' anyframe-widget-cdr
  bindkey '^R' anyframe-widget-put-history

  # hchbaw/auto-fu.zsh
  function zle-line-init () {
    auto-fu-init
  }
  zle -N zle-line-init
  zstyle ':auto-fu:var' postdisplay $''
  zstyle ':completion:*' completer _oldlist _complete

  # プロンプト設定
  autoload -U promptinit; promptinit
  prompt steeef

  # ===================================================
  # 開発環境
  # ===================================================
  # direnv
  if builtin command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
  fi

  # pip or others
  if [ -e "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
    export REDPEN_HOME="$HOME/.config/redpen"
    pip_cmd() {
        if builtin command -v pip3 > /dev/null; then
          if builtin command -v $1 > /dev/null; then
          else
              zsh -c "pip3 install --user $1"
           fi
        fi
    }
    pip_cmd flake8
    pip_cmd yapf
    pip_cmd isort
    pip_cmd yamllint
    pip_cmd jupyter
  fi

  # pyenv
  if [ -e "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
  fi

  # pipenv
  if builtin command -v pipenv > /dev/null; then
    eval "$(pipenv --completion)"
    function auto_pipenv_shell {
        if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
            if [ -f "Pipfile" ] ; then
                pipenv shell
            fi
        fi
    }
    auto_pipenv_shell
    add-zsh-hook zshaddhistory auto_pipenv_shell
  fi

  # node
  if [ -e "$HOME/.npm-global/bin" ]; then
    export PATH="$HOME/.npm-global/bin:$PATH"
  fi

  # yarn
  if [ -e "$HOME/.yarn/bin" ]; then
    export PATH="$HOME/.yarn/bin:$PATH"
    yarn_cmd() {
        if builtin command -v $1 > /dev/null; then
        else
          zsh -c "yarn add -G $1"
        fi
    }
    yarn_cmd prettier
    yarn_cmd vue
  fi

  # ruby
  if [ -e "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
  fi

  # ranger
  if builtin command -v ranger > /dev/null; then
    if [ ! -e "$HOME/.config/ranger/README.rst" ]; then
        if [ -d "$HOME/.config/ranger/" ]; then
            rm -rf $HOME/.config/ranger/
        fi
        git clone git@github.com:qh73xe/rangerrc.git  $HOME/.config/ranger
        if [ $DISTRIBUTION = "ubuntu" ]; then
            sh $HOME/.config/ranger/install.ubuntu.sh
        fi
    fi

    RANGER_CMD=$(which ranger)
    function ranger() {
        ime_off
        if [ -z "$RANGER_LEVEL" ]; then
            $RANGER_CMD $@
        else
            exit
        fi
    }
    alias config='ranger $HOME/.config'
    alias vimrc='ranger $HOME/.config/nvim'
    alias zshrc='ranger $HOME/.config/zsh'
    alias tmuxrc='ranger $HOME/.config/tmux'
    alias rangerrc='ranger $HOME/.config/ranger'
  fi
fi
