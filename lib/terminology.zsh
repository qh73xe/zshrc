DEBUG=0

if builtin command -v terminology > /dev/null; then
  export ECORE_IMF_MODULE=ibus
  LC_TIME="ja_JP.UTF-8"
fi
