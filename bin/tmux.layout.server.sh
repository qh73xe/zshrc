PANE_WIDTH=$(tmux display-message -p '#{pane_width}')
tmux split-window -h -t1
tmux resize-pane -t 1 -L $((PANE_WIDTH/4))
tmux split-window -v -t1
