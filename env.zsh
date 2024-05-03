#########################################
################## ENV ##################
#########################################


###### NVM ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###### GOLANG ######
export GOPATH=$HOME/golang
export GOROOT=$HOME/go
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/golang/bin

###### JAVA ######
export JAVA_HOME="$HOME/.jdks/corretto-17.0.10"
