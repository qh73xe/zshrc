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
