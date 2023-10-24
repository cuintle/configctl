# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

export LANG=en_US.UTF-8

export GPG_TTY=$(tty)

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZSH="$HOME/.oh-my-zsh"

function reload(){
    source $ZSH/oh-my-zsh.sh
}

bindkey "\e[1;2D" backward-char
bindkey "\e[1;2C" forward-char

export HISTCONTROL=ignoredups

CASE_SENSITIVE="true"

DISABLE_UNTRACKED_FILES_DIRTY=true

HIST_STAMPS="dd/mm/yyyy"

setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

setopt extendedglob

export HISTORY_IGNORE="(ls|bc|clear|exit|cd|cd ..|cd -)"

export SECURE_HIST="(age|age-keygen|aws|ssh|gocryptfs|iwd|nmcli|python3|python|poetry|pdm|watchfiles|git|uvcorn|ytdl)"

# for some reason, that im too lazy to find out,
# fc -p -a  ~/.encrypted_zsh_history is not working properly
# nor the !!:0 or !:0 to get last executed command (without args)
secure_history() {
  emulate -L zsh
  setopt extendedglob
  LAST_COMMAND=$(echo $1 | cut -d " " -f1)
  [[ "$LAST_COMMAND" =~ ${~SECURE_HIST} ]] && HISTFILE=~/.encrypted_zsh_history || HISTFILE=~/.zsh_history
}

[[ -d "$ZSH" ]] && reload


plugins=(
  aws
  poetry
  python
  pdm
)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='micro'
fi

# Can be dangerous
alias pip3-full-upgrade='pip3 list --outdated --format freeze --local --user | \
cut -d= -f1 | xargs --no-run-if-empty pip3 install --upgrade'

alias ytdl='yt-dlp --concurrent-fragments 10'

# The following lines were added by compinstall
zstyle :compinstall filename '/home/cuintle/.zshrc'

zstyle ':completion:*' rehash true    

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':omz:update' frequency 7


autoload -Uz compinit add-zsh-hook
add-zsh-hook zshaddhistory secure_history
compinit

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
