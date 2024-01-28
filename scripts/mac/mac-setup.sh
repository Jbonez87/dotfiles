#!/bin/env bash

SCRIPTDIR=`cd "$(dirname "$0")" && pwd`
DEFAULT_APPS_SCRIPT="$SCRIPTDIR/default-apps.sh"
HOMEBREW_SCRIPT="$SCRIPTDIR/utils/homebrew.sh"

echo "Run app defaults script first? (Please choose Yes or No)"
select script_choice in yes no; do
  case $script_choice in
    "yes")
      echo "Running app defaults script!"
      bash $DEFAULT_APPS_SCRIPT
      break
    ;;
    "no")
      echo "Moving on then."
      break
    ;;
    *)
      echo "Invalid choice"
    ;;
  esac
done

cd $HOME

if ! [ -d "${HOME}/projects" ]; then
  echo "Creating projects directory!"
  mkdir $HOME/projects
else
  echo "$HOME/projects directory already exists!"
fi

if ! [ -x "$(command -v brew)" ]; then
  echo "Brew not found. Would you like to install Homebrew?"
  select $brew_choice in yes no; do
    case $brew_choice in
      "yes")
        bash $HOMEBREW_SCRIPT
        break
      ;;
      "no")
        echo "Skipping Homebrew installation then."
        break
      ;;
      *)
        echo "Invalid choice."
      ;;
    esac
  done
else
  echo "Updating Homebrew!"
  brew update
fi

if ! [ -d "${HOME}/.nvm/.git" ]; then
  echo "Installing NVM!"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
else
  echo "NVM already installed!"
fi

if ! [ -x "$(command -v rustc)" ]; then
  echo "Installing Rust!"
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
else
  echo "Rust already installed!"
fi

export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

echo "Verifying nvm installation!"
command -v nvm

echo "Verifying nvm version"
nvm --version

if ! [ -x "$(command -v node)" ]; then
  echo "Installing node!"
  nvm install node
else
  echo "Node already installed!"
  node --version
fi

echo "Creating your SSH keys! Please follow the prompts."

echo "What is your personal email address?"
read -p "Email address is: " email

echo "Follow the prompts to save your ssh key. You can choose whether or not to add a password."

if [ -f $HOME/.ssh/id_ed25519 ]; then
  echo "id_ed25519 ssh key already exists!"
else
  ssh-keygen -t ed25519 -C "$email"

  echo "Adding your personal ssh key to your identity!"
  ssh-add ~/.ssh/id_ed25519
fi

echo "What is your work email?"
read -p "Work email is: " work_email

if [ -f $HOME/.ssh/work ]; then
  echo "Work ssh key already exists!"
else
  ssh-keygen -t ed25519 -C "$work_email" -f "$HOME/.ssh/work"

  echo "Adding your personal ssh key to your identity!"
  ssh-add ~/.ssh/work
fi

echo "Creating SSH config!"

echo "What is your username for personal projects?"
read -p "Personal username is: " personal_username

if [ -f $HOME/.ssh/config ]; then
  echo "SSH config already exists!"
else
  touch ~/.ssh/config
  cat << EOF >> ~/.ssh/config
  Host ssh.dev.azure.com
  HostName ssh.dev.azure.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/work

  Host github.com-$personal_username
  HostName github.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
fi

echo "Creating .gitconfig files!"

echo "What is your full name?"

read -p "Name is: " entered_name

if [ -f $HOME/.gitconfig-personal ]; then
  echo ".gitconfig-personal already exists!"
else
  touch ~/.gitconfig-personal
  cat << EOF >> ~/.gitconfig-personal
  [user]
    name = $entered_name
    email = $email
    username = $personal_username
  [core]
    sshCommand = "ssh -i ~/.ssh/id_ed25519"
  [init]
    defaultBranch = main
EOF
fi

if [ -f $HOME/.gitconfig-work ]; then
  echo ".gitconfig-work already exists!"
else
  touch ~/.gitconfig-work

  cat << EOF >> ~/.gitconfig-work
  [user]
    name = $entered_name
    email = $work_email
  [core]
    sshCommand = "ssh -i ~/.ssh/work"
  [init]
    defaultBranch = main
EOF
fi

if [ -f $HOME/.gitconfig ]; then
  echo ".gitconfig already exists!"
else
  touch ~/.gitconfig

  cat << EOF >> ~/.gitconfig
  [includeIf "gitdir:~/projects/personal/"]
    path = ~/.gitconfig-personal
  [includeIf "gitdir:~/projects/work/"]
    path = ~/.gitconfig-work
  [pull]
    rebase = false
  [diff]
    tool = vscode
  [difftool "vscode"]
    cmd = code --wait --diff $LOCAL $REMOTE

  [init]
    defaultBranch = main
EOF
fi

echo "Mac setup complete!"