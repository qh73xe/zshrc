# ------------------------------------
# tmux
# ------------------------------------
if builtin command -v tmux > /dev/null; then
  # tmux の設定ファイルがなかったら持って来る
  if [ ! -e "$HOME/.config/tmux/README.md" ]; then
    if [ -d "$HOME/.config/tmux/" ]; then
      rm -rf $HOME/.config/tmux/
    fi
    if [ -d "$HOME/.tmux.config" ]; then
      rm -rf $HOME/.tmux.config
    fi
    git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugins/tmux-powerline
    git clone git@github.com:qh73xe/tmuxrc.git $HOME/.config/tmux
    ln $HOME/.config/tmux/tmux.conf $HOME/.tmux.conf
  fi
  # tmux の多重起動を防止
  TMUX_CMD=$(which tmux)
  function tmux() {
    if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
      export TMUX_POWERLINE_SEG_WEATHER_LOCATION="26237038"
      export TERM=xterm-256color
      $TMUX_CMD $@ && exit
    fi
  }
  # tmux の自動起動
  if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
    tmux
  else
    function tmux.layout.server() {
      sh $ZSH_BIN_DI/tmux.layout.server.sh
    }
  fi
fi
