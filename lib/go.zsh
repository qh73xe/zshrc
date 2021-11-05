if builtin command -v go > /dev/null; then
  export GOPATH=$(go env GOPATH)
  export PATH=$PATH:$GOPATH/bin
fi
