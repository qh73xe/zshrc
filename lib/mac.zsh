# MAC で NUMBA を導入するための設定
if [ -e "/opt/homebrew/opt/llvm@11/bin" ]; then
  export PATH="/opt/homebrew/opt/llvm@11/bin:$PATH"
  export LLVM_CONFIG="llvm-config"
fi


# MAC で node のバージョン管理を行うための設定
if [ -e "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    \. "/opt/homebrew/opt/nvm/nvm.sh"
  fi
  if [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]; then
      \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  fi
fi
