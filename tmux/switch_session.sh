#!/usr/bin/env bash

REPO_ROOT="$HOME/repos"
START_SCRIPT="$HOME/repos/config/tmux/shell_start.sh"

DIR=$(find "$REPO_ROOT" -mindepth 1 -maxdepth 1 -type d | fzf --prompt="Pick repo: ")

[ -z "$DIR" ] && exit 0

SESSION_NAME=$(basename "$DIR")

# If already in a tmux session
if [ -n "$TMUX" ]; then
  if tmux has-session -t "$SESSION_NAME" 2> /dev/null; then
    tmux switch-client -t "$SESSION_NAME"
  else
    # Spawn session in background
    TMUX= tmux new-session -ds "$SESSION_NAME" -c "$REPO"
    tmux send-keys -t "$SESSION_NAME":0.0 'vim .' C-m
    tmux split-window -t "$SESSION_NAME":0 -v -c "$DIR"
    tmux select-pane -t "$SESSION_NAME":0.1
    tmux new-window -t "$SESSION_NAME" -c "$DIR" -n 'shell'
    tmux select-window -t "$SESSION_NAME":0
    tmux switch-client -t "$SESSION_NAME"
  fi
else
  "$START_SCRIPT" "$REPO"
fi
