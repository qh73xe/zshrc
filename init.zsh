# ====================================
# 基本設定
# ====================================

# 言語設定
export LANG=ja_JP.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# ディレクトリエイリアス
hash -d proj=~/Documents/proj
hash -d prod=~/Documents/prod
hash -d corpora=~/Documents/corpora

# エイリアス
alias cdc='cd ~/.config'
setopt AUTO_CD # cdコマンドを省略
setopt AUTO_PUSHD # cdしたら自動でディレクトリスタックする
setopt PUSHD_IGNORE_DUPS # 同じディレクトリは追加しない
