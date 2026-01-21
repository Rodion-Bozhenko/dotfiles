function sudo-it
    if test -z (commandline)
        commandline -r $history[1]
    end
    
    set -l cmd (commandline)
    set -l editor $EDITOR
    
    if test -z "$editor"
        set editor nvim
    end
    
    if string match -q 'sudo -e *' -- $cmd
        commandline -r (string replace 'sudo -e ' "$editor " -- $cmd)
    else if string match -q 'sudo *' -- $cmd
        commandline -r (string replace 'sudo ' '' -- $cmd)
    else if string match -q "$editor *" -- $cmd
        commandline -r (string replace "$editor " 'sudo -e ' -- $cmd)
    else
        commandline -r "sudo $cmd"
    end
    
    commandline -f repaint
end

bind \e\e sudo-it

set -g fish_history_size 1000000
set -g fish_history_max 1000000

set -g fish_greeting

set -gx EDITOR nvim
set -gx GOPATH "$HOME/go"
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'
set -gx _ZO_DATA_DIR "$HOME/.local/share"
set -gx LESS '-R --use-color'
set -gx HF_HUB_OFFLINE 1
set -gx ZK_NOTEBOOK_DIR "$HOME/personal/zk_notebook/notebook"

fish_add_path "$HOME/bin"
fish_add_path "/usr/local/bin"
fish_add_path "$HOME/.config/emacs/bin"
fish_add_path "$GOPATH/bin"

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

fzf --fish | source

zoxide init fish | source

starship init fish | source
