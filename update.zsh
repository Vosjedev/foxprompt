
#
# custom updater.
#

function foxshell-update {

    echo "getting latest version number..."
    _server_version="$(curl -# "https://vosjedev.pii.at/zsh/version.txt" -o -)"
    if [[ "$_server_version" == "" ]]; then
        echo "Error getting version number."
        exit 3
    fi
    if [[ "$_server_version" -eq "$_FOX_VERSION" ]]; then
        echo "Already up to date."
        exit 0
    fi

    cd ~/.zsh.plugins.d
    echo "git pulling update..."
    git pull
    echo "done."
    _old_version="$_FOX_VERSION"
    source "~/.zsh.plugins.d/version.zsh"
    
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

    echo "adding new settings entries"
    for i in $(range "$_old_version" "$_FOX_VERSION"); do
        echo "version: $i"
        echo -e "# new for version $i:\n$(curl https://vosjedev.pii.at/configs/zshrc/$i)" >> ~/.zshrc
    done
}
