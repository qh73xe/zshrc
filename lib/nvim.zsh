if builtin command -v nvim > /dev/null; then
  # nvim の設定ファイルがなかったら持って来る
  if [ ! -e "$HOME/.config/nvim/README.md" ]; then
    if [ -d "$HOME/.config/nvim/" ]; then
      rm -rf $HOME/.config/nvim/
    fi
    git clone git@github.com:qh73xe/nvim.git  $HOME/.config/nvim
    if [ $DISTRIBUTION = "ubuntu" ]; then
      .  $HOME/.config/nvim/setup/setup.ubuntu.zsh
    fi
  fi
  alias vi='nvim'
  alias vim='nvim'
  export EDITOR=nvim
else
  alias vi='vim'
  alias nvim='vim'
  export EDITOR=vim
fi
