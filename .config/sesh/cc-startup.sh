#!/usr/bin/env bash
# Split right column (35% width)
tmux split-window -h -l 35%
# Split right column into top (lazygit) and bottom (shell)
tmux split-window -v -t:.2
# Start lazygit in top-right pane
tmux send-keys -t:.2 'lazygit' Enter
# Focus back to left pane and start claude
tmux select-pane -t:.1
exec claude
