#!/bin/zsh

#      .___  __       .__  .__   __        .__  ____     
# ()/  |__  /  \ \_/  |__) |__) /  \ |\ /| |__)  |       
#  /() |    \__/ / \  |    | \  \__/ | | | |     |   ___ 
# by vosjedev (vosjedev.github.io)

#PROMPT='%F{green}%2c%F{blue} [%f '
#RPROMPT='$(git_prompt_info) %F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{blue}G:(%f"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{blue})%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}x%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}v%f"

ZSH_THEME_RUBY_PROMPT_PREFIX="%F{blue}R:(%f"
ZSH_THEME_RUBY_PROMPT_SUFFIX="%F{blue})%f"

#export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME_VIRTUALENV_PREFIX="%F{blue}E:(%f"
ZSH_THEME_VIRTUALENV_SUFFIX="%F{blue})%f"

autoload -U colors && colors
#function __mkprompt {
    function fg {
        echo -ne "\033[38;5;$1m"
    }
    function bg {
        echo -ne "\033[48;5;$1m"
    }
    function reset {
        echo -ne "\033[0m"
    }
#    _prompt_parts=()
#    _prompt_parts+="%{$(echo -ne "\033[1m")$(bg 3)%} 📂%{$(fg 15)%}%~ %{$(fg 3)$(bg 19)%}"
#    _prompt_parts+="🖥 %{$(fg 196)%}%n%F{normal}@%{$(fg 48)%}%m %{$(fg 19)$(bg 46)%}"
#    _prompt_parts+="%{$(fg 0)%}%? "
#    for part in $_prompt_parts; do
		
#}

PROMPT="%{$(echo -ne "\033[1m")$(bg 3)%} 📂%{$(fg 15)%}%~ %{$(fg 3)$(bg 19)%} 🖥 %{$(fg 196)%}%n%F{normal}@%{$(fg 48)%}%m %{$(fg 19)$(bg 46)%} %{$(fg 0)%}%? %{$(reset)$(fg 46)%} %f $(reset)
%{$(bg 3)$(fg 15)%} %#%{$(reset)$(fg 3)%}%{$(reset)%}"
PS2="%{$(bg 3)$(fg 15)%}  %{$(reset)$(fg 3)%}%{$(reset)%}"

#PROMPT='$(__mkprompt)'
#RPROMPT='$(git_prompt_info)$(virtualenv_prompt_info)$(ruby_prompt_info)'

## %F{8}${SSH_TTY:+%n@%m}





