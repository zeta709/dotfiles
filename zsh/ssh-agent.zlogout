# vim: ft=zsh:noexpandtab:sw=4:ts=4
# See how-to-configure-ssh-agent.md
# Do not copy and paste both of this file and ssh-agent.zprofile
if [ -n "$SSH_AGENT_PID" ]; then
	/usr/bin/ssh-agent -k
fi
