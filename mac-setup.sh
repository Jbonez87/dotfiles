#!/bin/bash

cd ~
mkdir ~/projects

echo "Installing homebrew! Install Xcode Command Line Tools when prompted!"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing core homebrew packages!"
brew bundle

echo "Installing NVM!"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

echo "Verifying nvm installation!"
command -v nvm

echo "Verifying nvm version"
nvm --version

echo "Installing node!"
nvm install node

node --version

echo "Creating an SSH key! Please follow the prompts."

echo "What is your email address?"

read -p "Email address is: " email

echo "Follow the prompts to save your ssh key. You can choose whether or not to add a password."

ssh-keygen -t ed25519 -C "$email"

echo "Adding your ssh key to your identity!"
ssh-add ~/.ssh/id_ed25519

echo "Creating .gitconfig file!"

echo "What is your full name?"

read -p "Name is: " entered_name

touch ~/.gitconfig

cat << EOF >> ~/.gitconfig
[user]
  name = $entered_name
  email = $email
[core]
	sshCommand = "ssh -i ~/.ssh/id_ed25519"
[init]
	defaultBranch = main
EOF

echo "Mac setup complete!"