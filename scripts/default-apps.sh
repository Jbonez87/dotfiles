#!/bin/env bash

echo "Do you prefer bash or zsh? (Please answer bash or zsh to run)"
read -p "Preferred shell is:" preferred

if [ $preferred == "bash" ]; then
  echo "Bash selected!"
  chsh -s /bin/bash
elif [ $preferred == "zsh" ]; then
  echo "Zsh selected!"
  chsh -s /bin/zsh
fi

# Install Xcode Command Line Tools
xcode-select --install

# Install Slack
curl -o slack.dmg https://downloads.slack-edge.com/releases/macos/Slack-latest.dmg
hdiutil mount slack.dmg
cp -R "/Volumes/Slack.app" /Applications/
hdiutil unmount "/Volumes/Slack.app"
rm slack.dmg

# Install Postman
curl -o postman.zip https://dl.pstmn.io/download/latest/osx
unzip postman.zip
rm postman.zip
mv Postman.app /Applications/

# Install Visual Studio Code
curl -o vscode.zip https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal
unzip vscode.zip
rm vscode.zip
mv "Visual Studio Code.app" /Applications/

# Download & install Firefox
curl -o firefox.dmg "https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
hdiutil mount firefox.dmg
sudo cp -r "/Volumes/Firefox/Firefox.app" "/Applications/"
hdiutil unmount "/Volumes/Firefox"
rm firefox.dmg

# Download & install Google Chrome
curl -o googlechrome.dmg https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg
hdiutil mount googlechrome.dmg
sudo /Volumes/Google\ Chrome/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --install
sudo mv "/Volumes/Google Chrome/Google Chrome.app" "/Applications/"
open -a "Google Chrome" --args --make-default-browser
hdiutil unmount /Volumes/Google\ Chrome
rm googlechrome.dmg

# Install VLC Player
curl -L -o vlc.dmg "https://get.videolan.org/vlc/3.0.16/macosx/vlc-3.0.16.dmg"
hdiutil mount vlc.dmg
cp -R "/Volumes/vlc-3.0.16/VLC.app" /Applications/
hdiutil unmount "/Volumes/vlc-3.0.16"
rm vlc.dmg

# Install Brave Browser
curl -L -o brave.dmg "https://laptop-updates.brave.com/latest/osx"
hdiutil mount brave.dmg
cp -R "/Volumes/Brave Browser/Brave Browser.app" /Applications/
hdiutil unmount "/Volumes/Brave Browser"
rm brave.dmg

# Install Visual Studio Code
curl -L -o vscode.zip "https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
unzip vscode.zip
rm vscode.zip
mv "Visual Studio Code.app" /Applications/

# Install Discord
curl -L -o discord.dmg "https://discord.com/api/download?platform=osx"
hdiutil mount discord.dmg
cp -R "/Volumes/Discord/Discord.app" /Applications/
hdiutil unmount "/Volumes/Discord"
rm discord.dmg

# Install MongoDB Compass
curl -L -o mongodb-compass.dmg "https://downloads.mongodb.com/compass/mongodb-compass-1.28.1-macos-x64.dmg"
hdiutil mount mongodb-compass.dmg
cp -R "/Volumes/MongoDB Compass/MongoDB Compass.app" /Applications/
hdiutil unmount "/Volumes/MongoDB Compass"
rm mongodb-compass.dmg