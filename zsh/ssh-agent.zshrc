# vim: ft=zsh:noexpandtab:sw=4:ts=4
# the code below should be placed at $HOME/.zshrc
if [[ -n "$SSH_AGENT_PID" ]]; then
	if [[ -f "$HOME/.exec-ssh-agent" && ! -s "$HOME/.exec-ssh-agent" ]]; then
		rm -f "$HOME/.exec-ssh-agent"
	fi
fi
