#!/bin/env bash

SCRIPTDIR=`cd "$(dirname "$0")" && pwd`
DEFAULT_APPS_SCRIPT="$SCRIPTDIR/utils/default-apps.sh"
HOMEBREW_SCRIPT="$SCRIPTDIR/utils/homebrew.sh"
SSH_GITCONFIG_SCRIPT="$SCRIPTDIR/utils/ssh-gitconfig-setup.sh"

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
  select brew_choice in yes no; do
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
  echo "Homebrew is already installed! Would you like to update it?"
  select update_choice in yes no; do
    case $update_choice in
      "yes")
        brew upgrade
        break
      ;;
      "no")
        echo "Skipping Homebrew update then."
        break
      ;;
      *)
        echo "Invalid choice."
      ;;
    esac
  done
fi

if ! [ -d "${HOME}/.nvm/.git" ]; then
  echo "Installing NVM!"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
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

echo "Would you like to setup your ssh keys and gitconfig files?"
select ssh_choice in yes no; do
    case $ssh_choice in
      "yes")
        bash $SSH_GITCONFIG_SCRIPT
        break
      ;;
      "no")
        echo "Skipping SSH and Gitconfig setup then."
        break
      ;;
      *)
        echo "Invalid choice."
      ;;
    esac
  done

echo "Mac setup complete!"
