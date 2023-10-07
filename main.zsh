
export LC_CTYPE=en_US.UTF-8

# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'comp: %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 10
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' prompt 'comp:%e%#'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/nicolaas/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

setopt auto_cd

alias cl=clear

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

function calc {
    python3 -c "print($1)"
}

if "$_FOX_ENABLE_CMD_AUTOCLICKER" && command -v xdotool >/dev/null; then
    function autoclicker {
        while sleep $1; do
            xdotool click 1
        done
    }
fi

if "$_FOX_ENABLE_CMD_R"; then
    function r {
        echo "starting $1 with flags $@"
        $@ & # start job in background
        echo "getting job id..."
        job_id="$(jobs -l | grep $! | cut -d ']' -f 1 | cut -d '[' -f 2)" # get job id
        echo "disowning $@"
        disown $job_id # disown job
        if ! [[ "$(jobs)" == "" ]]; then echo -e "! OTHER JOBS RUNNING !\n$(jobs)\n! THIS MEANS I CAN'T EXIT !"; return 1; else echo "exiting..."; fi
        exit # exit to let job take window space
    }
fi

if [[ -f "$_FOX_ALARM_PATH" ]]; then
    function alarm {
    	sleep "$1"
    	shift
    	echo "Alarm reason: $@"
    	play -q "$_FOX_ALARM_PATH"
    }
fi

if command -v lf >/dev/null; then
    function d {
        # https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh
    	cd "$(command lf -print-last-dir "$@")"
    }
fi

function resh {
	[[ "$1" == "so" ]] && { source ~/.zshrc; return }
	zsh
	exit
}


alias bat="bat -n --paging=never"
alias page="bat -n --paging=always"

if "$_FOX_HINT_MICRO"; then
    function nano {
        echo "I recommend micro."
        read "?Are you sure you want nano? " _in
        if [[ "$_in" == "y" ]]; then
            "$(where nano|tail -n1)" "$@"
        fi
    }
fi

if "$_FOX_HINT_DOAS"; then
    function sudo {
        echo "I recommend doas."
        read "?Are you sure you want sudo? " _in
        if [[ "$_in" == "y" ]]; then
            "$(where sudo|tail -n1)" "$@"
        fi
    }
fi

unalias run-help 2>/dev/null >/dev/null
autoload run-help
alias help=run-help

function precmd {
    printf '\e[6 q'
}

command -v fastfetch >/dev/null && alias foxfetch="fastfetch --logo ~/.vosjedev-art-32x16-ascii.txt --color '38;5;3' --structure 'Title:Seperator:OS:Host:Shell:WM:Kernel:Disk:Display:Packages:Break:Colors'"
command -v orange >/dev/null || function orange { echo -ne '\e[38;5;3m 38;5;3 orange\e[0m\n' ; }


function range {
    _cnt=$1
    _limit=$2
    if [[ "$_limit" == '' ]]; then
        _limit=$1; _cnt=0
    fi
    [[ "$1" == '' ]] && echo -e "usage: range start end\nwhen end is ommitted, start is used as end, and 0 as start." && return 1

    while [[ "$_cnt" -le "$_limit" ]]; do
        echo -n "$_cnt "
        ((_cnt++))
    done
}

# plugins
for f in ~/.zsh.plugins.d/*; do
    [[ "$f" == *"/.zsh.plugins.d/main.zsh" ]] && continue
    [[ "$f" == *"/.zsh.plugins.d/README.md" ]] && continue
    source "$f"
done

# custom user configs
if [[ -f ~/.zsh.d/* ]]; then
    for f in ~/.zsh.d/*; do
        source "$f"
    done
fi


function hints {
    echo 'Welcome to vosjedev`s zsh modifications.
    To switch directory in a fancy way, type `d`.
    To go to a second line, use alt-enter. After that, enter is newline,
    alt-enter is accept&execute.
    To move current prompts to a multiline buffer, press alt-e.
    To toggle mouse support, use alt-m when in a prompt.
    Use `calc <calculation>` to perform a calculation using python.
    Use `alarm <time> <reason>` to set a timer for <time> minutes,
    and print <reason> when done. This requires to have a soundfile
    called `alarm.mp3` in your home (~) directory. This works perfect with &.
    Use `autoclicker <time>` to autoleftclick every <time>. Requires xdotool.
    Use `bat <file>` to cat with syntax highlighting.
    Use `page <file>` to do the above with a pager.
    Use `orange` to get the ascii code for my favorite 256-color-term-supported
    orange. Auto-disabled if a command `orange` already exists.
    Use foxfetch to run a modded fastfetch command. Requires fastfetch, and
    https://vosjedev.pii.at/random/logos/vosjedev-art-32x16-ascii.txt
    downloaded as `~/vosjedev-art-32x16-ascii.txt`.
    Use `resh` to restart zsh, and `resh so` to source `~/.zshrc`.
    Use c-v to paste the system clipboard in a zsh prompt.

    You can place your own `.zshrc` in `~/.zsh.d/` and we will make sure it gets loaded for you.
    '
}

# change true to false to disable hints hint at startup
if $_FOX_HINTS
then echo 'Type `hints` for some hints! (you can disable me in ~/.zshrc)'
fi
