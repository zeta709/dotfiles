#!/bin/bash

cat <<- "EOF" >> "$HOME/.zprofile"
case $- in
    *i*) ;;
    *) return;;
esac

if [ -z "$SSH_AGENT_PID" ]; then
    # If `exec ...` should fail, it would block the login forever.
    # By creating a temp file and removing it later,
    # it can check if the last attempt failed.
    if [ ! -f "$HOME/.exec-ssh-agent" ]; then
        if touch "$HOME/.exec-ssh-agent"; then
            exec /usr/bin/ssh-agent -t 15m /usr/bin/zsh
        fi
    fi
fi
EOF

cat <<- "EOF" >> "$HOME/.zshrc"
if [ -n "$SSH_AGENT_PID" ]; then
    if [ -f "$HOME/.exec-ssh-agent" ] && [ ! -s "$HOME/.exec-ssh-agent" ]; then
        rm -f "$HOME/.exec-ssh-agent"
    fi
fi
EOF
