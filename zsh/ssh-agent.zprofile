# the code below should be placed at $HOME/.zprofile
if [[ -z "$SSH_AGENT_PID" ]]; then
	# if `exec ...` should fail, it would block the login forever.
	# by creating a temp file and removing it later,
	# it can check if the last attempt failed.
	if [[ ! -f "$HOME/.exec-ssh-agent" ]]; then
		if touch "$HOME/.exec-ssh-agent"; then
			exec /usr/bin/ssh-agent -t 15m /usr/bin/zsh
		fi
	fi
fi
