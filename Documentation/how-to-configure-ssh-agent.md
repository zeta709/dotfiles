# How to configure ssh-agent

There are many ways to configure `ssh-agent`.

## Solution 1

The easiest way.

In `.bash_profile` or `.zprofile`:
``` sh
eval "$(/usr/bin/ssh-agent -s -t 15m)"
```

Do not forget to terminate the `ssh-agent` at logout otherwise you would have
a huge number of `ssh-agent` in the end.

In `.bash_logout` or `.zlogout`:
``` sh
if [[ -n "$SSH_AGENT_PID" ]]; then
    /usr/bin/ssh-agent -k
fi
```

Pros and cons:
- easy configuration
- a ssh-agent is not shared with other login shells
    - note that each tmux pane creates a new login shell
- a ssh-agent may not be killed if the shell is killed abruptly

## Solution 2

Save the output of `ssh-agent` and reuse environment variables.
There are a bunch of examples on the internet.

Pros and cons:
- a ssh-agent is shared with other login shells
- not easy to kill a ssh-agent

## Solution 3

You can use `exec ssh-agent command`.
The most straight-forward configuration would be like below.

In `.bash_profile` or `.zprofile`:
``` sh
# use this code with caution
if [[ -z "$SSH_AGENT_PID" ]]; then
    exec /usr/bin/ssh-agent -t 15m /usr/bin/zsh
fi
```

However, I found that if `exec ...` should fail, the remote login would fail.
This would block you from logging in forever. Thus, I added some safety check.

In `.bash_profile` or `.zprofile`:
``` sh
if [[ -z "$SSH_AGENT_PID" ]]; then
    # If `exec ...` should fail, it would block the login forever.
    # By creating a temp file and removing it later,
    # it can check if the last attempt failed.
    if [[ ! -f "$HOME/.exec-ssh-agent" ]]; then
        if touch "$HOME/.exec-ssh-agent"; then
	    # you may use your preferred shell instead of zsh
            exec /usr/bin/ssh-agent -t 15m /usr/bin/zsh
        fi
    fi
fi
```

In `.bashrc` or `.zshrc`:
``` sh
if [[ -n "$SSH_AGENT_PID" ]]; then
    if [[ -f "$HOME/.exec-ssh-agent" && ! -s "$HOME/.exec-ssh-agent" ]]; then
        rm -f "$HOME/.exec-ssh-agent"
    fi
fi
```

Pros and cons:
- a ssh-agent exits automatically if the shell terminates
- a sub-shell uses its parent's ssh-agent
    - within a tmux session, only one ssh-agent is used
- if the outermost shell exits, existing shells lose their ssh-agent

You can set the environment variables after re-attaching tmux.
``` sh
# This should be a shell function to modify environment variables
update-ssh-agent-env() {
    local tmp
    if tmp=$(tmux show-environment SSH_AGENT_PID) > /dev/null 2>&1; then
        SSH_AGENT_PID=${tmp#*=}
        export SSH_AGENT_PID
    fi
    if tmp=$(tmux show-environment SSH_AUTH_SOCK) > /dev/null 2>&1; then
        SSH_AUTH_SOCK=${tmp#*=}
        export SSH_AUTH_SOCK
    fi
}
```

