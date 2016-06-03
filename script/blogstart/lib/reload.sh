#!/bin/zsh
brows=Safari
cat << EOF | osascript -
tell application "$brows"
    reload active tab of window 1
end tell
EOF
