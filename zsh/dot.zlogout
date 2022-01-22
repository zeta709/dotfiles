if [[ -n "$SSH_AGENT_PID" ]]; then
	/usr/bin/ssh-agent -k
fi
