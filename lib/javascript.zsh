# ------------------------------------
# node
# ------------------------------------
if [ -e "$HOME/.npm-global/bin" ]; then
  export PATH="$HOME/.npm-global/bin:$PATH"
fi

# ------------------------------------
# yarn
# ------------------------------------
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
