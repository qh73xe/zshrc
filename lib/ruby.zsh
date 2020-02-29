# ------------------------------------
# ruby
# ------------------------------------
if [ -e "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

if builtin command -v bundle > /dev/null; then
    alias be='bundle exec'
fi
