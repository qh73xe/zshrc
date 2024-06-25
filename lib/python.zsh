# ------------------------------------
# local-pip
# ------------------------------------
if type python3 > /dev/null; then
  PYTHONBASE=`python3 -m site --user-base`
  export PATH="$PYTHONBASE/bin:$PATH"
  export REDPEN_HOME="$HOME/.config/redpen"
  pip_cmd() {
    if builtin command -v pip3 > /dev/null; then
      if builtin command -v $1 > /dev/null; then
      else
        zsh -c "pip3 install --user $1"
      fi
    fi
  }
  # pip_cmd flake8
  # pip_cmd yapf
  # pip_cmd isort
  # pip_cmd yamllint
fi

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
