export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

export PATH=$HOME/bin:/usr/local/bin:$HOME/.config/emacs/bin:$HOME/personal/outline-sdk/x/examples/outline-cli:$PATH

export ZSH="$HOME/.oh-my-zsh"

export EDITOR=nvim

plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden'

# zoxide data directory
export _ZO_DATA_DIR="$HOME/.local/share"

export LESS='-R --use-color'

export HF_HUB_OFFLINE=1

alias v="nvim"
alias vf=". ~/bin/vim-fzf"
alias s="~/bin/zellij-sessionizer"
alias t="~/bin/tmux-sessionizer"
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

source ~/.config/zsh/rose-pine-man/rose-pine-man.zsh
colorize_man rose-pine transparent

eval "$(starship init zsh)"
