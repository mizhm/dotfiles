if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
alias c="clear"
alias pn="pnpm"
alias v="nvim"
alias nv="nvim"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/minh/.nvm/versions/node/v22.14.0/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/minh/.local/bin"
export PATH="$HOME/opt/usr/local/bin:$PATH"
export TMPDIR="/tmp"

set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin
