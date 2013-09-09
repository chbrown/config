#!/usr/bin/env bash

echo "Taking ownership of the system Python's site-packages."
chown -R $USER:staff /Library/Python/2.7/site-packages/

echo 'Updating homebrew'
brew update

echo 'Installing several homebrew packages'
brew install ack autoconf automake bash curl jpegoptim libxml2 libyaml node proctools redis ruby wget youtube-dl

echo 'Setting some Mac OS X defaults'

echo '- Finder settings'
defaults write com.apple.finder AnimateInfoPanes -bool FALSE
defaults write com.apple.finder AnimateWindowZoom -bool FALSE
defaults write com.apple.finder AppleShowAllFiles FALSE
defaults write com.apple.finder AppleShowAllFiles TRUE
defaults write com.apple.finder DisableAllAnimations -bool TRUE
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool FALSE
defaults write com.apple.finder FXEnableSlowAnimation -bool FALSE
defaults write com.apple.finder QuitMenuItem -bool TRUE

echo '- Dock settings'
defaults write com.apple.dock launchanim -bool FALSE
defaults write com.apple.dock showhidden -bool TRUE
defaults write com.apple.dock show-process-indicators -bool TRUE
defaults write com.apple.dock no-glass -bool TRUE
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock workspaces-swoosh-animation-off -bool TRUE

echo '- Core apps settings'
defaults write com.apple.Safari WebKitWebGLEnabled -bool TRUE
defaults write com.apple.Safari IncludeDebugMenu 1
defaults write com.apple.Mail DisableReplyAnimations -bool TRUE
defaults write com.apple.iTunes show-store-arrow-links -bool FALSE
defaults write com.apple.iTunes allow-half-stars -bool TRUE
defaults write com.apple.iTunes hide-ping-dropdown -bool TRUE

echo '- Miscellaneous other settings'
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
defaults write com.adobe.AdobeUpdater.Admin Disable.Update -bool TRUE
defaults write NSGlobalDomain AppleShowAllExtensions -bool TRUE
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool FALSE
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
