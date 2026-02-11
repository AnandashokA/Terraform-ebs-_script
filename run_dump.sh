#!/bin/bash
set -e

SESSION_NAME="dump"
WORKING_DIR="/data"

QUERY=

echo "Tmux server commands are executing"

if ! command -v tmux &> /dev/null; then
    echo "Tmux not installed. But its okay I ll install"
    sudo apt-get update
    sudo apt-get install tmux
else 
    echo "Tmux is already installed. Proceeding with session creation."
fi

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  echo "tmux session '$SESSION_NAME' already exists"
else
  echo " Creating tmux session '$SESSION_NAME'"
  tmux new-session -d -s "$SESSION_NAME"
fi

tmux send-keys -t "$SESSION_NAME" "

set -e

# cd $WORKING_DIR
echo 'Starting Query 1 Execution'
$QUERY1
echo 'Query 1 Execution Completed'
echo 'Starting Query 2 Execution'
$QUERY2
echo 'Query 2 Execution Completed'
echo 'All Queries Executed Successfully'
" C-m

echo "tmux dump session jobs are completed"
echo "tmux a -t dump -  to monitor the progress"


 
