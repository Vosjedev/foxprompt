
if command -v fzf >/dev/null; then

source ~/.zsh.plugins.d/fzf-tab-completion/zsh/fzf-zsh-completion.sh
bindkey '^I' fzf_completion

fi
