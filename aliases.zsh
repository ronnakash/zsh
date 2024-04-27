#############################################
################## ALIASES ##################
#############################################


###### zsh ######
# alias zshconf="nvim -c \"cd ~/.config/zshconfig\""
alias zshconf="nv ~/.config/zshconfig/"
alias ls="eza_ls_func"
alias ll="eza_ll_func"
alias la="eza_la_func"
alias bat="batcat"
alias repeatcmd='repeat_command'


###### git ######
alias gco='git checkout'
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gs='git stash'
alias gsp='git stash pop'


###### docker ######
alias dco="docker-compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"
alias dka='docker container stop $(sudo docker ps -q)'


###### kubectl ######
alias k="kubectl"
alias kctx='kubectl config set-context --current --namespace'
alias kctxl='kubectl config set-context --current --namespace=log-analyzer'
alias kctxld='kubectl config set-context --current --namespace=log-analyzer-debug'
alias kctxt='kubectl config set-context --current --namespace=trace.ai'
alias kp='kubectl get pods'

alias klog='klog_func'


###### terraform ######
alias tf='sudo $(which terraform)'
alias tfa='sudo $(which terraform) apply'
alias tfd='sudo $(which terraform) destroy'


###### NEOVIM ######
# alias v=nvim
# alias nvimconf="nvim -c \"cd ~/.config/nvim\""
alias nvimconf="nv ~/.config/nvim/"
# alias nvimconf="nvim -c \"cd ~/.config/nvim\" ~/.config/nvim/lua/custom/plugins.lua"

###### GOLANG ######
alias gg='go generate'
alias goproj="go_project"
export LOG_LEVEL="debug"
