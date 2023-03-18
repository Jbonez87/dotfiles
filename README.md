# Dotfiles

These are a series of configuration files and setup scripts that install packages and presets that I've used over the years. This is generally kept up to date, but feel free to fork this repository and edit any of these files to suit your needs. The `mac-setup.sh` script will do the following:

1. Create a `~/projects` directory for you
2. Install Homebrew and run `brew bundle`
   a. If you already have a `Brewfile` in your home directory, answer `yes` to run `brew bundle` or `no` to skip.
3. Install `nvm`
4. Install `rust`
5. Create your `ssh keys` and `ssh configs` if they don't already exist.
6. Create your personal, work and global `.gitconfig` files.
