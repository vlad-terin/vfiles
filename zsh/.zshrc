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
zle -N fzf_project_search_widget fzf_project_search
zle -N fzf_text_search_widget ss


bindkey '^o' fzf_folder_search_widget
bindkey '^f' fzf_file_search_widget
bindkey '^p' fzf_project_search_widget
bindkey '^s' fzf_text_search_widget

fzf_file_search() {
  local file
  file=$(fd --type f --hidden --exclude .git --exclude node_modules . "$HOME" | fzf) && code -r "$file"
}
fzf_project_search() {
  local file
  # Use "." to represent the current directory from which the function is invoked
  file=$(fd --type f --hidden --exclude .git --exclude node_modules . . | fzf) && code -r "$file"
}

fzf_folder_search() {
  local folder
  folder=$(fd --type d --exclude .git --exclude node_modules . "$HOME" | fzf) && code -r "$folder"
}

ss() {
  local pattern
  read -rp "Enter search pattern: " pattern
  IFS=: read -r file line rest <<< "$(rg --column --line-number --no-heading --color=always --smart-case "$pattern" . | fzf --ansi --delimiter ':' --preview 'bat --color=always {1} --highlight-line {2}' --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')"
  if [[ -n $file && -n $line ]]; then
    code -r -g "${file}:${line}"
  fi
}

export PATH="$HOME/.local/bin":$PATH
export EDITOR=lvim
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.nvm/versions/node/v18.17.0/lib/node_modules:$PATH"
export PATH="$HOME/.nvm/versions/node/v18.17.0/bin:$PATH"
export OPENAI_API_KEY=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


export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bindkey '^r' startrecord.sh

export PATH=/Users/vlad/.local/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export PATH="/Applications:$PATH"

####################Video Recording########################
## ===================================================== ## 

# screencast() {
#   ffmpeg -f avfoundation -i "1:0" -r 30 -t 10 -pix_fmt yuv420p "$HOME/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
#   echo $! > /tmp/recordingpid
# }


# killrecording() {
#   recpid="$(cat /tmp/recordingpid)"
#   kill -INT "$recpid"
#   rm -f /tmp/recordingpid
# }

# zle -N screencast_widget screencast
# bindkey '^i' screencast_widget
# bun completions
[ -s "/Users/vlad/.bun/_bun" ] && source "/Users/vlad/.bun/_bun"
# eval 