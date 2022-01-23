# vim: ft=zsh:noexpandtab:sw=4:ts=4
# See how-to-configure-ssh-agent.md
# The code below should be placed at $HOME/.zprofile or its equivalent

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
