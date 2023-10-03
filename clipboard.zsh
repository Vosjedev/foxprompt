# https://unix.stackexchange.com/questions/634765/copying-text-with-ctrl-c-when-the-zsh-line-editor-is-active

function zle-clipboard-cut {
  if ((REGION_ACTIVE)); then
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | xclip -selection clipboard -in
    zle kill-region
  fi
}
zle -N zle-clipboard-cut

function zle-clipboard-copy {
  if ((REGION_ACTIVE)); then
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | xclip -selection clipboard -in
  else
    # Nothing is selected, so default to the interrupt command
    zle send-break
  fi
}
zle -N zle-clipboard-copy

function zle-clipboard-paste {
  if ((REGION_ACTIVE)); then
    zle kill-region
  fi
  LBUFFER+="$(xclip -selection clipboard -out)"
}
zle -N zle-clipboard-paste

function zle-pre-cmd {
  # We are now in buffer editing mode. Clear the interrupt combo `Ctrl + C` by setting it to the null character, so it
  # can be used as the copy-to-clipboard key instead
  stty intr "^@"
}
precmd_functions=("zle-pre-cmd" ${precmd_functions[@]})

function zle-pre-exec {
  # We are now out of buffer editing mode. Restore the interrupt combo `Ctrl + C`.
  stty intr "^C"
}
preexec_functions=("zle-pre-exec" ${preexec_functions[@]})

# The `key` column is only used to build a named reference for `zle`
for key     kcap    seq           widget              arg (
    cx      _       $'^X'         zle-clipboard-cut   _                     # `Ctrl + X`
    cc      _       $'^C'         zle-clipboard-copy  _                     # `Ctrl + C`
    cv      _       $'^V'         zle-clipboard-paste _                     # `Ctrl + V`
) {
  if [ "${arg}" = "_" ]; then
    eval "key-$key() {
      zle $widget
    }"
  else
    eval "key-$key() {
      zle-$widget $arg \$@
    }"
  fi
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}
