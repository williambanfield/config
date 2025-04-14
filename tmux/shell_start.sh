#!/bin/bash

REPO_ROOT="$HOME/repos"
DIR="$1"

echo "$1"

if [ -z "$DIR" ]; then
  DIR=$(find "$REPO_ROOT" -mindepth 1 -maxdepth 1 -type d | fzf --prompt="Pick repo: ")
fi

if [ -z "$DIR" ]; then
  echo "No project selected — starting fallback shell."
  exec tmux -2
fi
SESSION_NAME=$(basename "$DIR")

if [ -n "$TMUX" ]; then
  echo "Already inside tmux. Open a new terminal to start a fresh session."
  exit 1
fi

if tmux has-session -t "$SESSION_NAME" 2> /dev/null; then
  exec tmux attach -t "$SESSION_NAME"
fi

tmux new-session -s "$SESSION_NAME" -c "$DIR" -d -n 'vim'
tmux send-keys -t "$SESSION_NAME":0.0 'vim .' C-m
tmux split-window -t "$SESSION_NAME":0 -v -c "$DIR"
tmux select-pane -t "$SESSION_NAME":0.1
tmux new-window -t "$SESSION_NAME" -c "$DIR" -n 'shell'
tmux select-window -t "$SESSION_NAME":0
exec tmux attach -t "$SESSION_NAME"
