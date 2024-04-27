# OhMyZsh Configuration




## Usage:

1. clone the repository to ~/.config/zshconfig 

2. put the following in your .zshrc:
    ```sh
    # source init script
    source ~/.config/zshconfig/init.zsh
    # path to .oh-my-zsh
    export ZSH="/path/to/.oh-my-zsh"
    export $ZSH/oh-my-zsh.sh
    # source config
    source ~/.config/zshconfig/zshconfig.zsh
    ```
3. modify the existing files. If you would like to add more files, source them in the zshconfig.zsh file

## Structure:

 zshconfig

 ├── .gitignore               

 ├── aliases.zsh              

 ├── env.zsh                  

 ├── extentions               

 │ └── fzf.zsh   

 ├── functions.zsh            

 ├── init.zsh                 

 ├── paths.zsh                

 ├── README.md

 ├── todo.md

 └── zshconfig.zsh            
