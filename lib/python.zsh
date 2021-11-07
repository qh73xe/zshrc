# ------------------------------------
# local-pip
# ------------------------------------
# if [ -e "$HOME/.local/bin" ]; then
#     export PATH="$HOME/.local/bin:$PATH"
#     export REDPEN_HOME="$HOME/.config/redpen"
#     pip_cmd() {
#       if builtin command -v pip3 > /dev/null; then
#         if builtin command -v $1 > /dev/null; then
#         else
#           zsh -c "pip3 install --user $1"
#         fi
#       fi
#     }
#     pip_cmd flake8
#     pip_cmd yapf
#     pip_cmd isort
#     pip_cmd yamllint
#     pip_cmd jupyter
# fi

# ------------------------------------
# pyenv
# ------------------------------------
if [ -e "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# ------------------------------------
# image-j
# ------------------------------------
if [ -e "$HOME/Fiji.app/ImageJ-linux64" ]; then
  export PATH="$HOME/Fiji.app/:$PATH"
fi



# ------------------------------------
# pipenv
# ------------------------------------
# if builtin command -v pipenv > /dev/null; then
#   eval "$(pipenv --completion)"
#   alias penv='pipenv'
#   alias prun='pipenv run'
#   alias prunp='pipenv run python'
#   alias pnvim='pipenv run nvim'
#   alias pvim='pipenv run nvim'
#   function auto_pipenv_shell {
#     if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
#       if [ -f "Pipfile" ] ; then
#         pipenv shell
#       fi
#     fi
#   }
#   function cd {
#       builtin cd "$@"
#       auto_pipenv_shell
#   }
#   auto_pipenv_shell
# fi
