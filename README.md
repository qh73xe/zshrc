# zsh 設定ファイル

基本的には, zplug を使用して種々環境設定を行っています.
また, tmux との併用を行うため, できる限り一つの .zshrc を利用することを考えています.

そのため, zsh 環境であれば, 以下の手続きで導入が修了すると思われます.

```
$ sudo apt install zsh git tmux curl
$ git clone git@github.com:qh73xe/zshrc.git  ~/.config/zsh
$ cd ~/.config/zsh
$ ln .zshrc ~/.zshrc
```
