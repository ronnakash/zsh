# env and paths first
source ~/.config/zshconfig/env.zsh
source ~/.config/zshconfig/paths.zsh

# functions
source ~/.config/zshconfig/functions.zsh

# extentions
source ~/.config/zshconfig/extentions/dir_cache/dir_cach.zsh
source ~/.config/zshconfig/extentions/file_cache/file_cache.zsh
source ~/.config/zshconfig/extentions/fzf/fzf.zsh

# aliases, must be defined after functions and extentions
source ~/.config/zshconfig/aliases.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zshconfig/extentions/powerlevel10k/p10k.zsh ]] || source ~/.config/zshconfig/extentions/powerlevel10k/p10k.zsh

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
