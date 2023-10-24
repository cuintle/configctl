# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
if ! [[ "$PATH" =~ $HOME/.local/bin ]]
then
    PATH="$HOME/.local/bin:$PATH"
fi

[[ -n ${XDG_DATA_HOME:-} ]] || XDG_DATA_HOME="$HOME/.local/share"

[[ -n ${XDG_CONFIG_HOME:-} ]] || XDG_CONFIG_HOME="$HOME/.config"

[[ -n ${XDG_CACHE_HOME:-} ]] || XDG_CACHE_HOME="$HOME/.cache"

[[ -n ${XDG_STATE_HOME:-} ]] || XDG_STATE_HOME="$HOME/.local/state"

[[ ! "$PATH" =~ $XDG_DATA_HOME/flatpak/exports/bin ]] || PATH="$XDG_DATA_HOME/flatpak/exports/bin:$PATH"

# gh completion -s bash

export XDG_DATA_HOME
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
