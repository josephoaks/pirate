alias ll='ls -laG'
alias ls='ls -G'
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#export PS1="\h:\W \u\$ "
export PS1="${RESET}\[\e[96m\]\h\[\e[m\]:\[\e[95m\]\w\[\e[m\] \u\[\e[92m\]\$(__git_ps1)\[\e[m\]\$ "

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.bashrc
