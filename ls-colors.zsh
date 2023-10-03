
if command -v eza >/dev/null 2>/dev/null; then
    alias ls='eza --icons --color=auto'
    alias ll='eza --icons -l --color=auto'
    alias la='eza --icons -la --color=auto'
    alias l='eza --icons --color=auto'
else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -la --color=auto'
    alias l='ls --color=auto'
fi
