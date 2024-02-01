#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

autoload -Uz compinit
compinit

# history
HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

# plugins
plug "zap-zsh/vim"

plug "atoftegaard-git/zsh-omz-autocomplete"
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/completions"
plug "zap-zsh/fzf"
plug "zap-zsh/atmachine-prompt"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "undg/zsh-nvm-lazy-load"
plug "Freed-Wu/fzf-tab-source"
# After loading fzf-tab
zstyle ':completion:*' fzf-completion yes


# keybinds
bindkey '^ ' autosuggest-accept
zle -N fzf_folder_search_widget fzf_folder_search
zle -N fzf_file_search_widget fzf_file_search
zle -N fzf_text_search_widget fzf_text_search


bindkey '^o' fzf_folder_search_widget
bindkey '^f' fzf_file_search_widget
bindkey '^t' fzf_text_search_widget

fzf_file_search() {
  local file
  file=$(fd --type f --hidden --exclude .git --exclude node_modules . "$HOME" | fzf) && /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron "$file"
}

fzf_folder_search() {
  local folder
  folder=$(fd --type d --exclude .git --exclude node_modules . "$HOME" | fzf) && /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron "$folder"
}

fzf_text_search() {
  local pattern
  read -rp "Enter search pattern: " pattern
  local file
  file=$(rg --files-with-matches --no-ignore --hidden "$pattern" | fzf) && /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron "$file"
}


export PATH="$HOME/.local/bin":$PATH
export EDITOR=lvim
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.nvm/versions/node/v18.16.0/lib/node_modules:$PATH"
export PATH="$HOME/.nvm/versions/node/v18.16.0/bin:$PATH"
export OPENAI_API_KEY=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


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bindkey '^r' startrecord.sh

export PATH=/Users/vlad/.local/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="/Applications/MyApp:$PATH"
