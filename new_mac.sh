#!/usr/bin/env bash

# '-g' and '-globalDomain' are synonyms for NSGlobalDomain

echo '- Global: show all file extensions everywhere'
defaults write -g AppleShowAllExtensions -bool TRUE

echo '- Global: disable / reduce / hasten animation'
defaults write -g NSAutomaticWindowAnimationsEnabled -bool FALSE
defaults write -g NSWindowResizeTime -float 0.001

echo '- Global: disable automatic termination of apps with no active windows'
# apps that are automatically terminated when they have no windows open are
# sometimes only partially terminated (Preview.app, for example, keeps open
# its file descriptors until it explicitly quits)
defaults write -g NSDisableAutomaticTermination -bool TRUE

echo '- Screenshots: disabling drop shadows'
defaults write com.apple.screencapture disable-shadow -bool TRUE

echo '- Dock: Reducing animation and kitsch'
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock launchanim -bool FALSE
defaults write com.apple.dock no-glass -bool TRUE
defaults write com.apple.dock show-process-indicators -bool TRUE
defaults write com.apple.dock showhidden -bool TRUE
defaults write com.apple.dock workspaces-swoosh-animation-off -bool TRUE

echo '- Finder.app: showing full path, extensions, and reducing animations'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE
defaults write com.apple.finder AnimateInfoPanes -bool FALSE
defaults write com.apple.finder AnimateWindowZoom -bool FALSE
defaults write com.apple.finder AppleShowAllFiles FALSE
defaults write com.apple.finder DisableAllAnimations -bool TRUE
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool FALSE
defaults write com.apple.finder FXEnableSlowAnimation -bool FALSE
defaults write com.apple.finder QuitMenuItem -bool TRUE

echo '- Mail.app: Disabling animations and automatic name paste'
defaults write com.apple.Mail AddressesIncludeNameOnPasteboard -bool FALSE
defaults write com.apple.Mail DisableReplyAnimations -bool TRUE

echo '- Safari.app: Turning on debugging and webkit extras'
defaults write com.apple.Safari IncludeDebugMenu 1
defaults write com.apple.Safari WebKitDeveloperExtras -bool TRUE
defaults write com.apple.Safari WebKitWebGLEnabled -bool TRUE

echo '- iTunes.app: Enabling half stars, hiding ping and iTunes store arrows'
defaults write com.apple.iTunes allow-half-stars -bool TRUE
defaults write com.apple.iTunes hide-ping-dropdown -bool TRUE
defaults write com.apple.iTunes show-store-arrow-links -bool FALSE

echo '- Preview.app: Disabling persistence'
defaults write com.apple.Preview ApplePersistence -bool FALSE

echo '  Disabling crash report dialogs'
defaults write com.apple.CrashReporter DialogType none

echo '- Turning off .DS_Store dumping on network stores'
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

echo '- Turning off Launch Services quarantine'
defaults write com.apple.LaunchServices LSQuarantine -bool FALSE

echo '- Trying to disable Adobe updater'
defaults write com.adobe.AdobeUpdater.Admin Disable.Update -bool TRUE

echo '- Disabling Acrobat persistence'
defaults write com.adobe.Acrobat ApplePersistence -bool FALSE

echo '- Setting iTerm2 inactive pane dimming amount'
defaults write com.googlecode.iterm2 SplitPaneDimmingAmount -float 0.1

echo '- Disabling XCode "undo past save" warning'
defaults write com.apple.Xcode XCShowUndoPastSaveWarning FALSE

echo '- Setting XCode template organization name to "Henrian"'
defaults write com.apple.Xcode PBXCustomTemplateMacroDefinitions '{"ORGANIZATIONNAME" = "Henrian";}'

echo '- Excel: disabling restoring windows'
defaults write com.microsoft.Excel NSQuitAlwaysKeepsWindows -bool FALSE

echo '- Quicklook: allow selecting text in quicklook previews'
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

echo '- Silence startup chime'
sudo nvram SystemAudioVolume=%80
# to reset: sudo nvram -d SystemAudioVolume

# echo '- Hiding "postgres" user from login options'
# defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add postgres

# echo '- Not sure what this does'
# defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0

echo '- Chrome.app: Disable swipe navigation'
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
# defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool FALSE # magic mouse swipe

echo '- Disable Press-and-Hold to show accented characters (allowing key repeat)'
defaults write -g ApplePressAndHoldEnabled -bool FALSE

echo '- Shorten delay before key repeat'
# 120 is the longest option and 15 is the shortest option in System Preferences
defaults write -g InitialKeyRepeat -int 15

echo '- Increase rate when repeating held key'
# 120 is the slowest option and 2 is the fastest option in System Preferences
defaults write -g KeyRepeat -int 1

echo '- Disabling GameKit libraries'
# gamed is this process that hangs around and phones home all the time. No thanks.
# https://discussions.apple.com/thread/5521495
sudo defaults write /System/Library/LaunchAgents/com.apple.gamed Disabled -bool TRUE
launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed.plist # SIP must be disabled

echo '- Disabling Photo Moments'
# come on Apple I haven't opened Photos.app in years
# also, not sure if these do anything, since I'm just guessing Disabled will work as it does with others
sudo defaults write /System/Library/LaunchAgents/com.apple.photolibraryd Disabled -bool TRUE
sudo defaults write /System/Library/LaunchAgents/com.apple.cloudphotosd Disabled -bool TRUE

echo '- Prevent Photos and other apps from automatically launching when a media card is mounted'
defaults write com.apple.ImageCapture disableHotPlug -bool TRUE

echo '- Exclude /usr/local/lib/node_modules from TimeMachine backup'
# http://blog.wanderview.com/blog/2013/01/15/time-machine-and-npm/
tmutil addexclusion /usr/local/lib/node_modules

echo '- Disable Java automatic updates'
defaults write /Library/Preferences/com.oracle.java.Java-Updater JavaAutoUpdateEnabled -bool FALSE

echo '- Setting default handlers for Apple UTIs (Uniform Type Identifiers)'
duti ./duti
