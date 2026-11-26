if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
alias c="clear"
alias a="claude"
alias oc="opencode"
alias pn="pnpm"
alias v="nvim"
alias nv="nvim"
alias task="go-task"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/home/minh/.nvm/versions/node/v24.22.0/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/home/minh/.opencode/bin"
# Keep OpenCode native: skip ~/.claude skills and CLAUDE.md fallback
set -gx OPENCODE_DISABLE_CLAUDE_CODE 1
export PATH="$PATH:/home/minh/.bun/bin"
export PATH="$PATH:/home/minh/.local/bin"
export PATH="$PATH:/home/minh/Downloads/platform-tools/"
export PATH="$HOME/opt/usr/local/bin:$PATH"
export TMPDIR="/tmp"

set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin


# Added by Antigravity CLI installer
set -gx PATH "/home/minh/.local/bin" $PATH

# pnpm
set -gx PNPM_HOME '/home/minh/.local/share/pnpm'
if test "$PATH[1]" != "$PNPM_HOME/bin"
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
