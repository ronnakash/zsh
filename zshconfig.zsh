source $ZSH/oh-my-zsh.sh
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=7

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# alias ohmyzsh="mate ~/.oh-my-zsh"

#############################################
##################  Paths  ##################
#############################################


###### pnpm ######
export PNPM_HOME="/home/itzko/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"


###### android ######
export ANDROID_HOME=/usr/lib/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools


###### win ######
export WIN_HOME="/mnt/c/Users/ronna"
export DOCSPATH="/mnt/c/Users/ronna/Documents"




#############################################
################  functions  ################
#############################################

eza_func() {
     local eza_options="$1"
     local level=1
     local remove_level=false

     shift 1

    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -d=*|--level=*) 
                if [[ "${1#*=}" == "0" ]]; then
                    remove_level=true
                else
                    level="${1#*=}" 
                fi
                shift 1 
                ;;
            *) 
                echo "Unknown option: $1"
                return 1
                ;;
        esac
    done

    if ! "$remove_level"; then
        eza_options+=" --level=$level"
    fi

     eza_command="eza $eza_options"
     eval "$eza_command"
 }

eza_ll_func() {
     local eza_options="--long --color=always --git --no-filesize --no-time --tree --icons=always"
     eza_func "$eza_options" "$@"
 }

eza_ls_func() {
     local eza_options="--long --color=always --git --no-filesize --no-time --no-user --tree --icons=always --no-permissions"
     eza_func "$eza_options" "$@"
 }

repeat_command() {
    local command="$1"
    local interval="${2:-1}" # Default interval is 1 second
    while true; do
        eval "$command"
        sleep "$interval"
    done
}
alias repeatcmd='repeat_command'



#############################################
################## ALIASES ##################
#############################################


###### zsh ######
alias zshconf="nvim -c \"cd ~\" ~/.zshrc"
alias ls="eza_ls_func"
alias ll="eza_ll_func"
alias bat="batcat"


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

klog_func() {
  local pod_name
  pod_name=$(kubectl get pods | grep "$1" | awk '{print $1}')
  # Remove any trailing carriage return characters
  pod_name=$(echo "$pod_name" | tr -d '\r')
  if [ -n "$pod_name" ]; then
    kubectl logs "$pod_name"
  else
    echo "Error: No matching pod found."
  fi
}
alias klog='klog_func'


###### terraform ######
alias tf='sudo $(which terraform)'
alias tfa='sudo $(which terraform) apply'
alias tfd='sudo $(which terraform) destroy'


###### NEOVIM ######
# alias v=nvim
alias nvimconf="nvim -c \"cd ~/.config/nvim\""
# alias nvimconf="nvim -c \"cd ~/.config/nvim\" ~/.config/nvim/lua/custom/plugins.lua"

###### GOLANG ######

go_project() {
  local dir
  local ezacmd="eza --long --color=always --git --no-filesize --no-time --tree --level=1 --icons=always {}"
  dir=$(find ${1:-~/golang} -maxdepth 1 -mindepth 1 -type d 2>/dev/null | fzf --preview "$ezacmd" --height 40% --reverse +m) && cd "$dir" && nvim
}

alias gg='go generate'
alias goproj="go_project"
export LOG_LEVEL="debug"


#########################################
################## ENV ##################
#########################################


###### NVM ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###### GOLANG ######
export GOPATH=/home/itzko/golang
export GOROOT=/home/itzko/go
export PATH=$PATH:/home/itzko/go/bin
export PATH=$PATH:/home/itzko/golang/bin

###### JAVA ######
export JAVA_HOME="/home/itzko/.jdks/corretto-17.0.10"


#########################################
################## FZF ##################
#########################################

alias f='fzf --preview "batcat --color=always {}" --height 40% --reverse --bind="enter:execute(nvim {})"'

fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf --preview "eza --long --color=always --git --no-filesize --no-time --tree --level=2 --icons=always {}" --height 40% --reverse +m) && cd "$dir"
}

alias c='fzf_cd'
