source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]] ; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"export FZF_COMPLETION_TRIGGER='**'

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

export FZF_COMPLETION_PATH_OPTS="--walker file,dir,follow,hidden"
export FZF_COMPLETION_DIR_OPTS="--walker dir,follow"

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:$HOME/.local/bin"
nitch

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh) fzf --preview 'dig {}' "$@" ;;
    *) fzf --preview "--preview 'bat -n --color=always --line-range :500'" "$@" ;;
  esac
}

# Helpful aliases
alias  c='clear' 
alias ls='eza -lha --icons=auto --color=always --sort=name --group-directories-first'  
alias lt='eza --icons=auto --color=always --tree --level=3' 
alias cd="z"
alias refresh="source ~/.zshrc"

# pacman
alias get="sudo pacman -S --noconfirm"
alias remove="sudo pacman -Rns --noconfirm"
alias update="sudo pacman -Syu"

alias editzsh="nvim ~/.zshrc"
alias v="nvim"
alias vim="nvim"
alias vi="nvim"

alias projects="cd $HOME/Documents/Github/Projects"

alias g="geany"
alias lg="lazygit"
alias ya="yazi"
alias ld="lazydocker"

# visual
alias open="xdg-open"
alias cat='bat -p --color=always --theme="Dracula"'
alias bat='bat -p --color=always --theme="Dracula"'
alias q="exit"

alias ..='z ..'

# you may also use the following one
bindkey -s '^o' 'nvim $(fzf)\n'
bindkey -s '^e' 'yazi\n'
bindkey -s '^r' 'history | fzf\n'

# python environments
alias startenv="source '$PWD/bin/activate'"
alias deac="deactivate"
function createnv() {
  envpath=$1
  python3 -m venv "$PWD/$envpath"
  cd "$PWD/$envpath"
}

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Source the Lazyman shell initialization for aliases and nvims selector
# shellcheck source=.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
# Source the Lazyman .nvimsbind for nvims key binding
# shellcheck source=.config/nvim-Lazyman/.nvimsbind
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind
