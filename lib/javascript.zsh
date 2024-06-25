# ------------------------------------
# node
# ------------------------------------
# if [ -e "$HOME/.npm-global/bin" ]; then
#   export PATH="$HOME/.npm-global/bin:$PATH"
# fi

# ------------------------------------
# yarn
# ------------------------------------
# if [ -e "$HOME/.yarn/bin" ]; then
#   export PATH="$HOME/.yarn/bin:$PATH"
#   yarn_cmd() {
#     if builtin command -v $1 > /dev/null; then
#     else
#       zsh -c "yarn global add $1"
#     fi
#   }
#   yarn_cmd prettier
#   yarn_cmd vue
#   if [ "$DISTRIBUTION" = "WSL" ]; then
#     yarn_cmd wsl-open
#   fi
# fi
#
# ------------------------------------
# Deno
# ------------------------------------
if [ -e "$HOME/.deno" ]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

if builtin command -v wsl-open > /dev/null; then
  alias open='wsl-open'
fi
