# ------------------------------------
# tmux
# ------------------------------------
if builtin command -v tmux > /dev/null; then
    TMUX_CMD=$(which tmux)
    function tmux() {
        if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
            export TMUX_POWERLINE_SEG_WEATHER_LOCATION="26237038"
            export TERM=xterm-256color
            $TMUX_CMD $@
        fi
    }
    tmux
fi
