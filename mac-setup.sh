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

echo "Creating your SSH keys! Please follow the prompts."

echo "What is your personal email address?"
read -p "Email address is: " email

echo "Follow the prompts to save your ssh key. You can choose whether or not to add a password."

ssh-keygen -t ed25519 -C "$email"

echo "Adding your personal ssh key to your identity!"
ssh-add ~/.ssh/id_ed25519

echo "What is your work email?"
read -p "Work email is: " work_email

ssh-keygen -t ed25519 -C "$work_email" -f "$HOME/.ssh/work"

echo "Adding your personal ssh key to your identity!"
ssh-add ~/.ssh/work

echo "Creating SSH config!"

touch ~/.ssh/config

echo "What is your username for personal projects?"
read -p "Personal username is: " personal_username

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

echo "Creating .gitconfig files!"

echo "What is your full name?"

read -p "Name is: " entered_name

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

echo "Mac setup complete!"