export PATH=$PATH:$HOME/.cargo/bin
. "$HOME/.cargo/env"
PATH="/usr/bin:/bin:/usr/sbin:/sbin"

export PATH="${HOME}/.pyenv/shims:${PATH}"

export PNPM_HOME="/Users/jcastrillon/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

export HOMEBREW_EDITOR=nano
export NODE_REPL_HISTORY_FILE=~/.node_repl_history
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/bin:$PATH"
export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
export PATH=$PATH:/usr/sbin
