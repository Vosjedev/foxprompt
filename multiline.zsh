# MULTILINE!!! (maybe)
bindkey '^[e' push-line-or-edit
#bindkey '^M' self-insert-unmeta
#bindkey '^[^M' accept-line


# enter accepts when only one line found, else creates newline
function _zle_ml_enter {
    if ! [[ $BUFFER == *$'\n'* ]]; then
        zle accept-line
    else
        zle self-insert-unmeta
    fi
}
zle -N _zle_ml_enter
bindkey '^M' _zle_ml_enter

# alt-enter accepts when more than one line found, else creates newline
function _zle_ml_meta_enter {
    if [[ $BUFFER == *$'\n'* ]]; then
        zle accept-line
    else
        zle self-insert-unmeta
    fi
}
zle -N _zle_ml_meta_enter
bindkey '^[^M' _zle_ml_meta_enter
