#!/bin/bash

# check if code command is available
if ! command -v code &> /dev/null
then
    echo "VS Code is not installed or the code command is not available on this system."
    exit 1
fi

# declare array of extensions to install
declare -a extensions=(
    "bungcip.better-toml"
    "chriseckenrode.vscode-chester-atom"
    "dbaeumer.vscode-eslint"
    "donjayamanne.githistory"
    "eamodio.gitlens"
    "esbenp.prettier-vscode"
    "file-icons.file-icons"
    "MariusAlchimavicius.json-to-ts"
    "ms-vscode.atom-keybindings"
    "ritwickdey.LiveServer"
    "rust-lang.rust-analyzer"
    "WallabyJs.quokka-vscode"
    "zhuangtongfa.material-theme"
)

# loop through extensions and install them
for extension in "${extensions[@]}"
do
    code --install-extension $extension
done
