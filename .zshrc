if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/emacs/bin:$HOME/.local/share/nvim/mason/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

export EDITOR=nvim

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden'

# zoxide data directory
export _ZO_DATA_DIR="$HOME/.local/share"

export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

alias v="nvim"
alias vf=". ~/bin/vim-fzf"
alias s="~/bin/zellij-sessionizer"
# alias lf="~/.config/lf/lfrun"
alias cat="bat"
alias ls="exa"
alias zel="zellij"
alias mr="mongoshrun"
alias cht="~/bin/zel-cht.sh"
alias fzf="fzf --reverse"
alias cdf=". ~/bin/cd-fzf"
alias rmi="rm -ivr"
alias rip="rip -i"
alias cr="cargo run"
alias cb="cargo build"
alias ct="cargo test"
alias gr="go run"
alias gb="go build"
alias gt="go test"
alias diff="delta -s"

# bun completions
[ -s "/Users/rodionbozenko/.bun/_bun" ] && source "/Users/rodionbozenko/.bun/_bun"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/rodion/.opam/opam-init/init.zsh' ]] || source '/home/rodion/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
