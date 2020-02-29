if builtin command -v nvim > /dev/null; then
  alias vi='nvim'
  alias vim='nvim'
  export EDITOR=nvim
else
  alias vi='vim'
  alias nvim='vim'
  export EDITOR=vim
fi
