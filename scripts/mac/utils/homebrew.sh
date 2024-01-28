#!/bin/env bash

echo "Installing Xcode Command Line Tools first! Please accept when prompted."
xcode-select --install

echo "Installing homebrew!"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Would you like to check for an existing Brewfile and run brew bundle?"
select $brewfile_choice in yes no; do
  case $brewfile_choice in
    "yes")
      echo "Checking for Brewfile and installing core packages!"
      if [ -f $HOME/Brewfile ]; then
        echo "Brewfile already exists"
        cd $HOME
        brew bundle
        echo "Brewfile processed!"
      else
        echo "Copying over Brewfile!"
        unzip ../Brewfile.zip
        mv ../Brewfile $HOME
        brew bundle
      fi
      break
    ;;
    "no")
      echo "Skipping brew bundle then."
      break
    ;;
    *)
      echo "Invalid choice"
    ;;
  esac
done