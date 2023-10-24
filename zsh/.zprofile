# this file is installed as ~/.zprofile for newly created users

# prepend ~/.local/bin and ~/bin to $PATH unless it is already there
if ! [[ "$PATH" =~ $HOME/bin ]]
then
    PATH="$HOME/bin:$PATH"
fi

if ! [[ "$PATH" =~ $HOME/.local/bin ]]
then
    PATH="$HOME/.local/bin:$PATH"
fi


[[ "$XDG_DATA_HOME" =~ $HOME/.local/share ]] || XDG_DATA_HOME="$HOME/.local/share"

# [[ "$PATH" =~ "$XDG_DATA_HOME/JetBrains/Toolbox/scripts" ]] || PATH="$XDG_DATA_HOME/JetBrains/Toolbox/scripts:$PATH"

[[ "$XDG_CONFIG_HOME" =~ $HOME/.config ]] || XDG_CONFIG_HOME="$HOME/.config"

[[ "$XDG_STATE_HOME" =~ $HOME/.local/state ]] || XDG_STATE_HOME="$HOME/.local/state"

[[ "$XDG_CACHE_HOME" =~ $HOME/.cache ]] || XDG_CACHE_HOME="$HOME/.cache"

if ! [[ "$PATH" =~ $XDG_DATA_HOME/flatpak/exports/bin ]]
then
    PATH="$XDG_DATA_HOME/flatpak/exports/bin:$PATH"
fi

export GPG_TTY=$(tty)

gh completion -s zsh

export XDG_DATA_HOME
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
