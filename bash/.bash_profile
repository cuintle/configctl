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

[[ "$XDG_DATA_HOME" =~ $HOME/.local/share ]] || XDG_DATA_HOME="$HOME/.local/share"

[[ "$XDG_CONFIG_HOME" =~ $HOME/.config ]] || XDG_CONFIG_HOME="$HOME/.config"

[[ "$XDG_CACHE_HOME" =~ $HOME/.cache ]] || XDG_CACHE_HOME="$HOME/.cache"

if ! [[ "$PATH" =~ $XDG_DATA_HOME/flatpak/exports/bin ]]
then
    PATH="$XDG_DATA_HOME/flatpak/exports/bin:$PATH"
fi

gh completion -s bash

export XDG_DATA_HOME
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
