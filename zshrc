# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mary"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse")
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z man colored-man-pages fzf bgnotify osx)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Ruby
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export PATH="`ruby -e 'print Gem.user_dir'`/bin:${PATH}"

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="${JAVA_HOME}:${PATH}"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi
if [ "$TERM" = "screen" -o "$TERM" = "screen-256color" ]; then
    export TERM=screen-256color
    unset TERMCAP
fi

alias vim=vim
export EDITOR='vim'

alias so="source ~/.zshrc && rehash"
alias texdo="latexmk -c -pdf -gg -pvc -bibtex"
alias xetexdo="latexmk -xelatex -latexoption='-shell-escape -interaction=nonstopmode' -pvc -gg"
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'
alias tofinder='ofd'
alias fromfinder='cdf'
alias R='rtichoke'
alias sessions='tmux list-sessions'
alias detach='tmux detach'


#======================================================================================
# Config
#======================================================================================

# configs for fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_DEFAULT_OPTS='
    --extended
    --reverse
    --tac
    --tiebreak=length
    --color fg:252,bg:235,hl:112,fg+:252,bg+:235,hl+:161
    --color info:144,prompt:123,spinner:135,pointer:161,marker:118
'

#======================================================================================
# Z with fzf
#======================================================================================

# fzf for z
unalias z
function z {
    if [[ -z "$*" ]]; then
        cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf-tmux +s)"
    else
        _last_z_args="$@"
        cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf-tmux +s -q $_last_z_args)"
    fi
}

function zz {
    cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf-tmux -q $_last_z_args)"
}

alias j=z
alias jj=z

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


#======================================================================================
# tmux functions
#======================================================================================

function newsession {
   tmux new -s $1 
}

function attach {
    tmux a -t $1
}

function killsession {
   tmux kill-session -t $1 
}

function switch {
    tmux switch -t $1
}
