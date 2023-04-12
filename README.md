# Dotfiles

## Table of Contents

1. [Introduction](#introduction)
2. [Mac Users](#mac-users)
3. [Windows Users](#windows-users)

## Introduction

These are a series of configuration files and setup scripts that install packages and presets that I've used over the years. This is generally kept up to date, but feel free to fork this repository and edit any of these files to suit your needs. There is some support for Windows Users as well.

## Mac Users

To run the `mac-setup.sh` script, enter the following command: `sh mac-setup.sh`.

The `mac-setup.sh` script will do the following:

1. Create a `~/projects` directory for you
2. Install Homebrew and run `brew bundle`

   a. If you already have a `Brewfile` in your home directory, answer `yes` to run `brew bundle` or `no` to skip.

3. Install `nvm` and `node`
4. Install `rust`
5. Create your `ssh keys` and `ssh configs` if they don't already exist.
6. Create your personal, work and global `.gitconfig` files.

## Windows Users

To run the `windows-setup.bat` file, cd to the directory where you've cloned this repo to and enter the following command: `windows-setup.bat`

The `windows-setup.bat` script will do the following:

1. Install the [Chocolately Package Manager](https://chocolatey.org/)
2. Install `git` and [Git Bash](https://gitforwindows.org/)
3. Install `nvm` and `node`
4. Install `rust`
