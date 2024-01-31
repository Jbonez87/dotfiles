#!/bin/env bash

BASH_PROFILE="../../shells/.bash_profile"
ZSHENV="../../shells/.zshenv"
ZSHRC="../../shells/.zshrc"

echo "Do you prefer bash or zsh? (Please answer bash or zsh to run or press enter to skip.)"
select shell_choice in bash zsh; do
  case $shell_choice in
    "bash")
        echo "Bash selected!"
        chsh -s /bin/bash
        if ! [ -f $HOME/.bash_profile ]; then
            echo "Copying over bash_profile template!"
            cp $BASH_PROFILE $HOME
            source $HOME/.bash_profile
        else
            echo "Sourcing bash_profile!"
            source $HOME/.bash_profile
        fi
      break
    ;;
    "zsh")
        echo "Zsh selected!"
        chsh -s /bin/zsh
        if ! [[ -f $HOME/.zshenv && -f $HOME/.zshrc ]]; then
            cp $ZSHENV $HOME
            cp $ZSHRC $HOME
        fi
      break
    ;;
    *)
      echo "Moving on then."
      break
    ;;
  esac
done


# Check if xcode-select is installed
if xcode-select --version >/dev/null 2>&1; then
    echo "xcode-select is already installed."
else
    echo "Installing xcode-select!"
    # Install Xcode Command Line Tools
    xcode-select --install
fi

# Check if Chrome is installed
if mdfind "kMDItemContentType == com.apple.application-bundle && kMDItemDisplayName == 'Google Chrome.app'" | grep -q "Google Chrome.app"; then
    echo "Google Chrome is already installed."
else
    echo "Installing Google Chrome!"
    # Download & install Google Chrome
    curl -o googlechrome.dmg https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
    hdiutil mount googlechrome.dmg
    sudo /Volumes/Google\ Chrome/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --install
    sudo mv "/Volumes/Google Chrome/Google Chrome.app" "/Applications/"
    open -a "Google Chrome" --args --make-default-browser
    hdiutil unmount /Volumes/Google\ Chrome
    rm googlechrome.dmg
fi

# Check if Slack is installed
if [ -d "/Applications/Slack.app" ]; then
    echo "Slack is already installed."
else
    echo "Installing Slack!"
    # Install Slack
    curl -o slack.dmg https://downloads.slack-edge.com/releases/macos/Slack-latest.dmg
    hdiutil mount slack.dmg
    cp -R "/Volumes/Slack.app" /Applications/
    hdiutil unmount "/Volumes/Slack.app"
    rm slack.dmg
fi

# Check if VS Code is installed
if [ -d "/Applications/Visual Studio Code.app" ]; then
    echo "VS Code is already installed."
else
    echo "Installing VS Code!"
    # Install Visual Studio Code
    curl -L -o vscode.zip "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
    unzip vscode.zip
    rm vscode.zip
    mv "Visual Studio Code.app" /Applications/
fi

# Check if Postman is installed
if [ -d "/Applications/Postman.app" ]; then
    echo "Postman is already installed."
else
    echo "Installing Postman!"
    # Install Postman
    curl -o postman.zip https://dl.pstmn.io/download/latest/osx
    unzip postman.zip
    rm postman.zip
    mv Postman.app /Applications/
fi

# Check if Brave Browser is installed
if [ -d "/Applications/Brave Browser.app" ]; then
    echo "Brave Browser is already installed."
else
    echo "Installing Brave Browser!"
    # Install Brave Browser
    curl -L -o brave.dmg "https://laptop-updates.brave.com/latest/osx"
    hdiutil mount brave.dmg
    cp -R "/Volumes/Brave Browser/Brave Browser.app" /Applications/
    hdiutil unmount "/Volumes/Brave Browser"
    rm brave.dmg
fi

# Check if Firefox is installed
if mdfind "kMDItemContentType == com.apple.application-bundle && kMDItemDisplayName == 'Firefox.app'" | grep -q "Firefox.app"; then
    echo "Firefox is already installed."
else
    echo "Installing Firefox!"
    # Download & install Firefox
    curl -o firefox.dmg "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
    hdiutil mount firefox.dmg
    sudo cp -r "/Volumes/Firefox/Firefox.app" "/Applications/"
    hdiutil unmount "/Volumes/Firefox"
    rm firefox.dmg
fi

# Check if MongoDB Compass is installed
if [ -d "/Applications/MongoDB Compass.app" ]; then
    echo "MongoDB Compass is already installed."
else
    echo "Installing MongoDB Compass!"
    # Install MongoDB Compass
    curl -L -o mongodb-compass.dmg "https://downloads.mongodb.com/compass/mongodb-compass-1.28.1-macos-x64.dmg"
    hdiutil mount mongodb-compass.dmg
    cp -R "/Volumes/MongoDB Compass/MongoDB Compass.app" /Applications/
    hdiutil unmount "/Volumes/MongoDB Compass"
    rm mongodb-compass.dmg
fi

# Check if VLC Player is installed
if [ -d "/Applications/VLC.app" ]; then
    echo "VLC Player is already installed."
else
    echo "Installing VLC Player!"
    # Install VLC Player
    curl -L -o vlc.dmg "https://get.videolan.org/vlc/3.0.16/macosx/vlc-3.0.16.dmg"
    hdiutil mount vlc.dmg
    cp -R "/Volumes/vlc-3.0.16/VLC.app" /Applications/
    hdiutil unmount "/Volumes/vlc-3.0.16"
    rm vlc.dmg
fi

# Check if Discord is installed
if [ -d "/Applications/Discord.app" ]; then
    echo "Discord is already installed."
else
    echo "Installing Discord!"
    # Install Discord
    curl -L -o discord.dmg "https://discord.com/api/download?platform=osx"
    hdiutil mount discord.dmg
    cp -R "/Volumes/Discord/Discord.app" /Applications/
    hdiutil unmount "/Volumes/Discord"
    rm discord.dmg
fi

# Check if Zoom is installed
if [ -d "/Applications/zoom.us.app" ]; then
    echo "Zoom is already installed."
else
    echo "Installing Zoom!"
    curl -L -o /tmp/zoomusInstaller.pkg "https://zoom.us/client/latest/ZoomInstallerIT.pkg"
    sudo installer -pkg /tmp/zoomusInstaller.pkg -target /
    rm /tmp/zoomusInstaller.pkg
fi

if [[ $(command -v rancher-desktop) ]]; then
  echo "Rancher Desktop is already installed"
else
  # Download the Rancher Desktop .dmg file
  curl -LO https://github.com/rancher-sandbox/rancher-desktop/releases/download/v0.11.1/rancher-desktop-darwin-amd64.tar.gz

  # Extract the contents of the .dmg file
  hdiutil attach rancher-desktop-darwin-amd64.tar.gz

  # Copy the Rancher Desktop.app file to the /Applications directory
  cp -R /Volumes/Rancher\ Desktop/Rancher\ Desktop.app /Applications/

  # Eject the mounted .dmg file
  hdiutil detach /Volumes/Rancher\ Desktop/
fi
