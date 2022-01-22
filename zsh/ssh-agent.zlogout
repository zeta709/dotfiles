# vim: ft=zsh:noexpandtab:sw=4:ts=4
if [[ -n "$SSH_AGENT_PID" ]]; then
	/usr/bin/ssh-agent -k
fi
