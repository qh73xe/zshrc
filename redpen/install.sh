VERSION=1.10.0
URL=https://github.com/redpen-cc/redpen/releases/download/redpen-$VERSION/redpen-$VERSION.tar.gz
wget $URL -P /tmp
tar xvf "/tmp/redpen-$VERSION.tar.gz" -C "$HOME/.local/share/"
ln -s "$HOME/.local/share/redpen-distribution-$VERSION/bin/redpen" "$HOME/.local/bin/redpen"

if [ ! -e "$HOME/.config/redpen" ];
    then
    mkdir "$HOME/.config/redpen"
fi
