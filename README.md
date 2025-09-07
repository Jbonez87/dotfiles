# Dotfiles

## Table of Contents

1. [Introduction](#introduction)
2. [Mac Users](#mac-users)
3. [Windows Users](#windows-users)
4. [Gitconfigs](#gitconfigs)
5. [Gitignores](#gitignores)
6. [Scripts](#scripts)
7. [Shells](#shells)
8. [VS Code](#vs-code)
9. [Zed](#zed)

## Introduction

These are a series of configuration files and setup scripts that install packages and presets that I've used over the years. This is generally kept up to date, but feel free to fork this repository and edit any of these files to suit your needs. There is some support for Windows Users as well.

## Mac Users

To run the `mac-setup.sh` script:

1. Open your terminal
2. cd to the directory you've cloned this repo into.
3. Enter the following command: `bash ./scripts/mac/mac-setup.sh`.

The `mac-setup.sh` script will do the following:

1. Create a `~/projects` directory for you
2. Optionally runs the [default-apps](./scripts/mac/utils/default-apps.sh) script.

   a. Answer `yes` to run the `default-apps.sh` script.

3. Install Homebrew and run `brew bundle`

   a. If you already have a `Brewfile` in your home directory, answer `yes` to run `brew bundle` or `no` to skip.

4. Install `nvm` and `node`
5. Install `rust`
6. Create your `ssh keys` and `ssh configs` if they don't already exist.
7. Create your personal, work and global `.gitconfig` files.

## Windows Users

To run the `windows-setup.bat` file:

1. Open your `cmd` terminal using `Win + R`
2. cd to the directory where you've cloned this repo and enter the following command: `.\scripts\windows\windows-setup.bat`

The `windows-setup.bat` script will do the following:

1. Install the [Chocolately Package Manager](https://chocolatey.org/)
2. Install `git` and [Git Bash](https://gitforwindows.org/)
3. Install `nvm` and `node`
4. Install `rust`

## Gitconfigs

The [gitconfigs](./gitconfigs) directory has the base, personal and work **gitconfig** templates. Feel free to change these as you see fit, but be aware that the [mac-setup.sh](./mac-setup.sh) file automatically creates these files if they don't already exist on your machine.

## Gitignores

The [gitignores](./gitignores) directory has `node` and `rust` gitignore templates.

## Scripts

This is where all **Mac** and **Windows** app installation scripts will eventually go. Currently there is more support for **Mac Users**, but more scripts will be made for **Windows Users** in the future.

## Shells

This is where the [bash_profile](./shells/bash/.bash_profile), [zshrc](./shells/zsh/.zshrc) and [zshenv](./shells/zsh/.zshenv) templates are stored. These are moved to your `~` or **Home Directory** and sourced for your terminal.

## VS Code

All VS Code snippets, settings and launch JSON files will be stored here.

## Zed

All Zed settings will be stored here.
