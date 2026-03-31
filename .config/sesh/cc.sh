#!/usr/bin/env bash
# Usage: cc.sh [directory]
# Creates (or attaches to) a "cc" tmux session in the given directory,
# defaulting to the current working directory.

DIR="${1:-$PWD}"
DIR="$(cd "$DIR" 2>/dev/null && pwd)" || { echo "Invalid directory: $1"; exit 1; }
SESSION="cc"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  # Session exists — just switch/attach
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION"
  else
    tmux attach-session -t "$SESSION"
  fi
  exit 0
fi

# Create session (detached) rooted at DIR
tmux new-session -d -s "$SESSION" -c "$DIR"

# Split right column (35% width), rooted at DIR
tmux split-window -h -t "$SESSION" -l 35% -c "$DIR"
# Split right column top/bottom
tmux split-window -v -t "$SESSION:1.2" -c "$DIR"

# Start lazygit in top-right pane
tmux send-keys -t "$SESSION:1.2" 'lazygit' Enter

# Start claude in left pane
tmux send-keys -t "$SESSION:1.1" 'claude' Enter

# Attach or switch
if [ -n "$TMUX" ]; then
  tmux switch-client -t "$SESSION"
else
  tmux attach-session -t "$SESSION"
fi
