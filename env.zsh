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
