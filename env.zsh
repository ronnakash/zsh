#########################################
################## ENV ##################
#########################################


###### NVM ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


###### GOLANG ######
export GOPATH=$HOME/golang
export GOROOT=/usr/local/go/
export PATH=$PATH:/usr/local/go/bin

###### JAVA ######
# export JAVA_HOME="$HOME/.jdks/corretto-17.0.10"



###### python ######

 
# tcl-tk
export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/tcl-tk/lib/pkgconfig"
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"


