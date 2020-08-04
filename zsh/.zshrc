export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="refined"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Common aliases
alias n="nvim"
alias zconfig="nvim ~/.zshrc"
alias nconfig="n ~/.config/nvim/init.vim"

# Git aliases
alias gcl="git clone"
alias gp="git pull"
alias gf="git fetch"
alias gc="git commit --signoff"
alias gcp="git cherry-pick"
alias gi="git init"
alias ga="git add"
alias gaa="git add ."
alias gra="git remote add"
alias grv="git remote -v"
alias gb="git branch"
alias gsw="git switch"
alias gs="git status"
alias gl="git log"
alias glo="git log --pretty=oneline"
alias gco="git checkout"
alias gr="git rebase"
alias gri="git rebase -i"

# gpg related
export GPG_TTY=$(tty)

# search and replace string recursively on git repos
# this uses git so the changes can be reverted if its destructive
gitreplace() {
    echo -n "Are you sure you want to replace $1 with $2? (y/n)"
    read answer
    if echo "$answer" | grep -iq "^y" ;then
        git grep -lz "$1" | xargs -0 sed -i "s/$1/$2/g"
    else
        echo "Cancelled command" ; exit
fi
}
