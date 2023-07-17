# A list of all directories in which to look for commands,
# scripts and programs                              
PATH="/usr/bin:/bin:/usr/sbin:/sbin"

export BASH_SILENCE_DEPRECATION_WARNING=1

# =================
# History
# =================

# http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Make some commands not show up in history
export HISTIGNORE="h"

export HOST_IP=`echo "show State:/Network/Global/IPv4" | scutil | grep PrimaryInterface | awk '{print $3}' | xargs ifconfig | grep inet | grep -v inet6 | awk '{print $2}'`
export HOST_IP=${HOST_IP:='127.0.0.1'}

# ====================
# Aliases
# ====================

# Updates homebrew and its packages
alias brewup='brew update && brew upgrade && brew cleanup'

# Automatically goes to the root directory of macbook
alias ~='cd ~'

# A better ls
alias ll='ls -FGlAhp'

alias ls='ls -GFh'

# A more detailed ls command
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

# Finds the top memory hogs
alias memHogsTop='top -l 1 -o rsize | head -20'

# finds the top ten memory hogs
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# Finds the top CPU hogs
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# More detailed ip info
alias ip='whoami ; echo -e \ - Public facing IP Address: ; curl ipecho.net/plain ; echo ; echo -e \ - Internal IP Address: ;  ipconfig getifaddr en0'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Rails stuff
alias rs='rails s'

# Goes directly to my desktop
alias dt='cd ~/Desktop/'

# Goes directly to my projects folder
alias projects='cd ~/projects/'

#Quickly add my applications to my applications folder
alias afolder='open ~/Applications/'

# Allows me to pull from WDI repo
alias gpum='git pull upstream master'

# Runs local mongo instance with correct db path
alias m0ngod='mongod --config /usr/local/etc/mongod.conf'

# Show's me a detailed git log
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

# Runs webpack dev server
alias rundev='npm run dev'

alias cleanup_packages='rm -Rf node_modules package-lock.json'

# Runs create-react-app scripts
alias cra='npx create-react-app'

# update npm
alias npmup='npm i -g npm'

# Opens up different programs from terminal
alias spotify='open -a Spotify'
alias slack='open -a Slack'
alias postman='open -a Postman'
alias gitchat='open -a Gitter'
alias itunes='open -a itunes'
alias xcode='open -a xcode'

# Creates boilerplate files for app creation
alias tih='touch index.html'
alias sjs='touch server.js'
alias ijs='touch index.js'
alias wpc='touch webpack.config.js'

# Make edits to .bash_profile and refresh .bash_profile
alias c.='code .'
alias cbp='code ~/.bash_profile'
alias sbp='source ~/.bash_profile'

# Go back one directory
alias b='cd ..'

# History lists your previously entered commands
alias h='history'

# If we make a change to our bash_profile we need to reload it
alias reload="clear; source ~/.bash_profile"

### Open apps
alias chrome='open -a Google Chrome'
alias safari='open -a Safari'

alias get_homebrew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

alias rctrdx='npm i react react-dom prop-types redux react-redux redux-thunk redux-logger'

alias wp='npm i -D webpack webpack-dev-server babel-core babel-loader babel-preset-env babel-preset-react babel-plugin-transform-object-rest-spread babel-preset-stage-0'

alias npminit="npm init -y"

alias remove_node_modules="cd ~/projects & find . -name 'node_modules' -type d -prune -exec rm -Rf '{}' +"

alias mong0d="mongod --port 27017 --dbpath  /usr/local/var/mongodb"
alias mconfigfile="cd /usr/local/etc/mongod.conf"
alias b64Token="node -e \"require('readline') .createInterface({input:process.stdin,output:process.stdout,historySize:0}) .question('PAT> ',p => { b64=Buffer.from(p.trim()).toString('base64');console.log(b64);process.exit(); })\""

# =================
# Functions
# =================

#######################################
# Set ACL permissions to inherit and
# allow read, write and update actions.
#
# Arguments:
#   1. Group Name
#   2. Directory Path
#######################################

allow_group() {
  local GROUP_NAME="$1"
  local TARGET_DIR="$2"
  local PERMISSIONS="read,write,delete,add_file,add_subdirectory"
  local INHERITANCE="file_inherit,directory_inherit"

  sudo mkdir -p "$TARGET_DIR"
  sudo /bin/chmod -R -N "$TARGET_DIR"
  sudo /bin/chmod -R +a "group:$GROUP_NAME:allow $PERMISSIONS,$INHERITANCE" "$TARGET_DIR"
}

make_simple_react() {
  mkdir "$1" 
  cd "$1"
  npminit
  rctrdx
  wp
  wpc
  mkdir "src"
  cd "src/"
  mkdir "static"
  cd "static"
  tih
  cd ".."
  ijs
  mkdir "components"
  cd "components/"
  touch "App.js"
  cd "../.."
  c.
  echo -e "$1 project created"
}

#######################################
# Start an HTTP server from a directory
# Arguments:
#  Port (optional)
#######################################

server() {
  local port="${1:-8000}"
  (sleep 2 && open "http://localhost:${port}/")&

  # Simple Pythong Server:
  # python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"

  # Simple Ruby Webrick Server:
  ruby -e "require 'webrick';server = WEBrick::HTTPServer.new(:Port=>${port},:DocumentRoot=>Dir::pwd );trap('INT'){ server.shutdown };server.start"
}

#######################################
# List any open internet sockets on
# several popular ports. Useful if a
# rogue server is running.
# - http://www.akadia.com/services/lsof_intro.html
# - http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
#
# No Arguments.
#######################################

rogue() {
  # add or remove ports to check here!
  local PORTS="3000 4567 6379 8000 8888 27017"
  local MESSAGE="> Checking for processes on ports"
  local COMMAND="lsof"

  for PORT in $PORTS; do
    MESSAGE="${MESSAGE} ${PORT},"
    COMMAND="${COMMAND} -i TCP:${PORT}"
  done

  echo "${MESSAGE%?}..."
  local OUTPUT="$(${COMMAND})"

  if [ -z "$OUTPUT" ]; then
    echo "> Nothing running!"
  else
    echo "> Processes found:"
    printf "\n$OUTPUT\n\n"
    echo "> Use the 'kill' command with the 'PID' of any process you want to quit."
    echo
  fi
}

function get_global_packages() {
  npm ls -g --depth 0
}

# =================
# Tab Improvements
# =================

## Tab improvements
bind 'set completion-ignore-case on'
# # make completions appear immediately after pressing TAB once
bind 'set show-all-if-ambiguous on'
bind 'TAB: menu-complete'

# =================
# Sourced Scripts
# =================

shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

function deleteAllBranchesExceptMaster() {
    git checkout master
    git branch | grep -v '^*' | xargs git branch -d 
}
function deleteAllBranchesExceptMasterForce() {
    git checkout master
    git branch | grep -v '^*' | xargs git branch -D
}
function deleteAllBranchesExceptMain() {
    git checkout master
    git branch | grep -v '^*' | xargs git branch -d 
}
function deleteAllBranchesExceptMainForce() {
    git checkout master
    git branch | grep -v '^*' | xargs git branch -D
}

# export PS1="\[\033[36;40m\]\u\[\033[32m\] \w \[\033[31m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.split(%r{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\[\033[37m\]$\[\033[00m\] "

# export PS1='\[\033[36m\]\u\[\033[0m\] \[\033[32m\]\w\[\033[0m\] \[\033[38;5;88m\]$(__git_ps1 "(%s) ")\[\033[0;38;5;178m\]\$\[\033[0m\] '

export PS1='\[\033[36m\]\u\[\033[0m\] \[\033[32m\]\w\[\033[0m\] \[\033[38;5;88m\]$(__git_ps1 "(%s)")\[\033[00m\] \$ '

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"


# ====================================
# Environmental Variables and API Keys
# ====================================

# Below here is an area for other commands added by outside programs or
# commands. Attempt to reserve this area for their use!
##########################################################################

export HOMEBREW_EDITOR=nano
export NODE_REPL_HISTORY_FILE=~/.node_repl_history
export LSCOLORS=GxFxCxDxBxegedabagaced
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/bin:$PATH"
export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    if ! IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)); then
      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    if ! IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)); then

      local ret=$?
      IFS="$si"
      return $ret
    fi
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
. "$HOME/.cargo/env"

export PNPM_HOME="/Users/jcastrillon/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3
