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


[[ -n ${XDG_DATA_HOME:-} ]] || XDG_DATA_HOME="$HOME/.local/share"

[[ -n ${XDG_CONFIG_HOME:-} ]] || XDG_CONFIG_HOME="$HOME/.config"

[[ -n ${XDG_CACHE_HOME:-} ]] || XDG_CACHE_HOME="$HOME/.cache"

[[ -n ${XDG_STATE_HOME:-} ]] || XDG_STATE_HOME="$HOME/.local/state"

if ! [[ "$PATH" =~ $XDG_DATA_HOME/flatpak/exports/bin ]]
then
    PATH="$XDG_DATA_HOME/flatpak/exports/bin:$PATH"
fi

export GPG_TTY=$(tty)

gh completion -s zsh

export XDG_DATA_HOME
export XDG_CONFIG_HOME
export XDG_CACHE_HOME
