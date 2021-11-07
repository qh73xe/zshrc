# ------------------------------------
# zplug
# ------------------------------------
if [ ! -e "$HOME/.zplug" ]; then
  curl -sL --proto-redir -all,https \
  https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
else
  export ZPLUG_HOME="$HOME/.zplug"
  source $HOME/.zplug/init.zsh

  zplug "zsh-users/zsh-history-substring-search"
  zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
  zplug "mollifier/anyframe"

  # 情報追加
  zplug "tcnksm/docker-alias", use:zshrc

  # シンタックスハイライト
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "chrissicool/zsh-256color"

  # GIT 関連
  zplug "plugins/git",   from:oh-my-zsh
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
  zplug mafredri/zsh-async, from:github
  zplug 'dracula/zsh', as:theme

  # gibo
  zplug 'simonwhitaker/gibo', use:'gibo', as:command

  # Install plugins if there are pl
  if ! zplug check --verbose; then
    zplug install
  fi
  zplug load

  # ------------------------------------
  # 各種 プラグイン設定
  # ------------------------------------
  # mollifier/cd-gitroot
  alias cdg='cd-gitroot'

  # mollifier/anyframe
  DIRSTACKSIZE=100 # スタックサイズ
  zstyle ":anyframe:selector:" use peco
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  bindkey '^Z' anyframe-widget-cdr
  bindkey '^R' anyframe-widget-put-history

  # hchbaw/auto-fu.zsh
  function zle-line-init () {
    auto-fu-init
  }
  zle -N zle-line-init
  zstyle ':auto-fu:var' postdisplay $''
  zstyle ':completion:*' completer _oldlist _complete
fi
