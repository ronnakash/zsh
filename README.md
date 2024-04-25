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
3. modify the existing files. If you would like to add more files, source them in the zshconfig.sh file

## Structure:

  .

 ├──  .gitignore               

 ├──  aliases.zsh              aliases

 ├──  env.zsh                  environment variables

 ├──  extentions               for specific tools

 │  └──  fzf.zsh   

 ├──  functions.zsh            function definitions

 ├──  init.zsh                 init script

 ├──  paths.zsh                paths to export as environment variables

 ├──  README.md

 ├──  todo.md

 └──  zshconfig.zsh            sources all non-init scripts
