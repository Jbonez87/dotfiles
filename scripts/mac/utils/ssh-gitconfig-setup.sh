#!/bin/env bash

echo "Creating your SSH keys and git config files! Please follow the prompts."

echo "What will you be using this machine for?"
select ssh_choice in work "personal projects" both; do
  case $ssh_choice in
    "work")
      echo "What is your work email?"
      read -p "Work email is: " work_email
      
      if [ -f $HOME/.ssh/id_ed25519 ]; then
        echo "Work ssh key already exists!"
      else
        ssh-keygen -t ed25519 -C "$work_email"

        echo "Adding your work ssh key to your identity!"
        ssh-add $HOME/.ssh/id_ed25519
      fi

      echo "Creating SSH config!"

      if [ -f $HOME/.ssh/config ]; then
        echo "SSH config already exists!"
      else
        touch $HOME/.ssh/config
      cat << EOF >> $HOME/.ssh/config
        Host *
          User git
          AddKeysToAgent yes
          UseKeychain yes
          IdentityFile $HOME/.ssh/id_ed25519
EOF
      fi

      echo "Creating .gitconfig file!"

      echo "What is your full name?"
      read -p "Name is: " entered_name

      if [ -f $HOME/.gitconfig ]; then
        echo ".gitconfig already exists!"
      else
        touch $HOME/.gitconfig
        cat << EOF >> $HOME/.gitconfig
        [user]
          name = $entered_name
          email = $work_email
        [core]
          sshCommand = "ssh -i $HOME/.ssh/id_ed25519"
          excludesfile = $HOME/.gitignore_global
        [credential]
	        helper = osxkeychain
        [init]
          defaultBranch = main
        [pull]
          rebase = false
EOF
      fi
      break
    ;;
    "personal projects")
      echo "What is your personal email address?"
      read -p "Email address is: " email

      echo "Follow the prompts to save your ssh key. You can choose whether or not to add a password."

      if [ -f $HOME/.ssh/id_ed25519 ]; then
        echo "id_ed25519 ssh key already exists!"
      else
        ssh-keygen -t ed25519 -C "$email"

        echo "Adding your personal ssh key to your identity!"
        ssh-add $HOME/.ssh/id_ed25519
      fi

      echo "Creating SSH config!"

      if [ -f $HOME/.ssh/config ]; then
        echo "SSH config already exists!"
      else
        touch $HOME/.ssh/config
      cat << EOF >> $HOME/.ssh/config
        Host *
          User git
          AddKeysToAgent yes
          UseKeychain yes
          IdentityFile $HOME/.ssh/id_ed25519
EOF
      fi

      echo "Creating .gitconfig file!"

      echo "What is your full name?"
      read -p "Name is: " entered_name

      echo "What is your username for personal projects?"
      read -p "Personal username is: " personal_username

      if [ -f $HOME/.gitconfig ]; then
        echo ".gitconfig already exists!"
      else
        touch $HOME/.gitconfig
        cat << EOF >> $HOME/.gitconfig
        [user]
          name = $entered_name
          email = $email
          username = $personal_username
        [core]
          sshCommand = "ssh -i $HOME/.ssh/id_ed25519"
          excludesfile = $HOME/.gitignore_global
        [credential]
	        helper = osxkeychain
        [init]
          defaultBranch = main
        [pull]
          rebase = false
EOF
      fi
      break
    ;;
    "both")
      echo "What is your personal email address?"
      read -p "Email address is: " email

      echo "What is your work email?"
      read -p "Work email is: " work_email

      echo "Creating SSH config!"

      echo "What is your username for personal projects?"
      read -p "Personal username is: " personal_username

      if [ -f $HOME/.ssh/config ]; then
        echo "SSH config already exists!"
      else
        touch $HOME/.ssh/config
        cat << EOF >> $HOME/.ssh/config
        Host ssh.dev.azure.com
        HostName ssh.dev.azure.com
        User git
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile $HOME/.ssh/work

        Host github.com-$personal_username
        HostName github.com
        User git
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile $HOME/.ssh/id_ed25519
EOF
      fi

      echo "Creating .gitconfig files!"

      echo "What is your full name?"
      read -p "Name is: " entered_name

      if [ -f $HOME/.gitconfig-personal ]; then
        echo ".gitconfig-personal already exists!"
      else
        touch $HOME/.gitconfig-personal
        cat << EOF >> $HOME/.gitconfig-personal
        [user]
          name = $entered_name
          email = $email
          username = $personal_username
        [core]
          sshCommand = "ssh -i $HOME/.ssh/id_ed25519"
        [init]
          defaultBranch = main
EOF
      fi

      if [ -f $HOME/.gitconfig-work ]; then
        echo ".gitconfig-work already exists!"
      else
        touch $HOME/.gitconfig-work

        cat << EOF >> $HOME/.gitconfig-work
        [user]
          name = $entered_name
          email = $work_email
        [core]
          sshCommand = "ssh -i $HOME/.ssh/work"
        [init]
          defaultBranch = main
EOF
      fi

      if [ -f $HOME/.gitconfig ]; then
        echo ".gitconfig already exists!"
      else
        touch $HOME/.gitconfig

        cat << EOF >> $HOME/.gitconfig
        [includeIf "gitdir:$HOME/projects/personal/"]
          path = $HOME/.gitconfig-personal
        [includeIf "gitdir:$HOME/projects/work/"]
          path = $HOME/.gitconfig-work
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
      break
    ;;
    *)
      echo "Invalid choice"
    ;;
  esac
done