#!/bin/sh
# Automatically sets defaults for macOS
# see https://mths.be/macos

# shellcheck source=script/helpers.sh
source "$HOME/.dotfiles/script/helpers.sh"

enter_sudo

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit'


info "macOS Preferences"
echo

_general() {
    #########################
    ###   General UI/UX   ###
    #########################

    # Avoid creating '.DS_Store' files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Make crash reports appear as notifications
    defaults write com.apple.CrashReporter UseUNC 1

    # Disable 'Are you sure you want to open this application?' dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Expand save panel by default
    defaults write NSGlobalDomain /tilesizeNSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Save to disk (not to iCloud) by default
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Disable the “Are you sure you want to open this application?” dialog
    defaults write com.apple.LaunchServices LSQuarantine -bool false

    # Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

    # Disable Resume system-wide
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    # Accelerated playback when adjusting the window size
    defaults write -g NSWindowResizeTime -float 0.001

    # Show battery percentage in menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string 'YES'

    killall "SystemUIServer" &> /dev/null


    #############################
    ###   Language & Region   ###
    #############################

    defaults write -g AppleLanguages -array "en"
    defaults write -g AppleMeasurementUnits -string "Centimeters"
}
task "General UI/UX" _general


_devices() {
    #######################################################################
    ###   Trackpad, mouse, keyboard, Bluetooth accessories, and input   ###
    #######################################################################

    # Trackpad: enable tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Map 'click or tap with two fingers' to the secondary click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
    defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
    defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
    defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0

    # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Set a fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 1
    defaults write NSGlobalDomain InitialKeyRepeat_Level_Saved -int 10

    # Disable smart dashes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    # Disable smart quotes as they’re annoying when typing code
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # Disable automatic capitalization as it’s annoying when typing code
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

    # Disable automatic period substitution as it’s annoying when typing code
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
}
task "Trackpad, mouse, keyboard and accessories" _devices

_screen() {
    ##################
    ###   Screen   ###
    ##################

    # Require password immediately after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    # Save screenshots to the desktop
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true

    # Enable subpixel font rendering on non-Apple LCDs
    # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
    defaults write NSGlobalDomain AppleFontSmoothing -int 1

    # Enable HiDPI display modes (requires restart)
    sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
}
task "Screen settings" _screen

_dock() {
    ###########################
    ###   Dock, Dashboard   ###
    ###########################

    # Wipe all icons in Dock
    defaults write com.apple.dock persistent-apps -array
    defaults write com.apple.dock persistent-others -array

    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true

    # Remove the auto-hiding Dock delay
    defaults write com.apple.dock autohide-delay -float 0

    # Enable spring loading for all Dock items
    defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

    # Make all Mission Control related animations faster
    defaults write com.apple.dock expose-animation-duration -float 0.1

    # Do not group windows by application in Mission Control
    defaults write com.apple.dock expose-group-by-app -bool false

    # Disable the opening of an application from the Dock animations
    defaults write com.apple.dock launchanim -bool false

    # Change minimize/maximize window effect
    defaults write com.apple.dock mineffect -string "scale"

    # Minimize windows into their application’s icon
    defaults write com.apple.dock minimize-to-application -bool true

    # Do not automatically rearrange spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Show indicator lights for open applications
    defaults write com.apple.dock show-process-indicators -bool true

    # Enable highlight hover effect for the grid view of a stack (Dock)
    defaults write com.apple.dock mouse-over-hilite-stack -bool true

    # Do not show recent applications in Dock
    defaults write com.apple.dock show-recents -bool false

    # Set the icon size of Dock items to 48 pixels
    defaults write com.apple.dock tilesize -int 48

    # Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    killall "Dock" &> /dev/null
}
task "Dock" _dock

_finder_and_spotlight() {
    ##################
    ###   Finder   ###
    ##################

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Search the current directory by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Use list view in all Finder windows by default
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

    # Do not show recent tags
    defaults write com.apple.finder ShowRecentTags -bool false

    # Show all filename extensions
    defaults write -g AppleShowAllExtensions -bool true

    # Set icon size
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 72" ~/Library/Preferences/com.apple.finder.plist

    # Set icon grid spacing size
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 1" ~/Library/Preferences/com.apple.finder.plist

    # Set icon label text size
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:textSize 13" ~/Library/Preferences/com.apple.finder.plist

    # Set icon label position
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:labelOnBottom true" ~/Library/Preferences/com.apple.finder.plist

    # Show item info
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

    # Set sort method
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy none" ~/Library/Preferences/com.apple.finder.plist

    #####################
    ###   Spotlight   ###
    #####################

    # Change indexing order and disable some search results
    defaults write com.apple.spotlight orderedItems -array \
        '{ enabled = 1; name = "APPLICATIONS"; }' \
        '{ enabled = 1; name = "MENU_EXPRESSION"; }' \
        '{ enabled = 1; name = "SYSTEM_PREFS"; }' \
        '{ enabled = 1; name = "DIRECTORIES"; }' \
        '{ enabled = 0; name = "DOCUMENTS"; }' \
        '{ enabled = 0; name = "PRESENTATIONS"; }' \
        '{ enabled = 0; name = "SPREADSHEETS"; }' \
        '{ enabled = 0; name = "PDF"; }' \
        '{ enabled = 0; name = "MESSAGES"; }' \
        '{ enabled = 0; name = "CONTACT"; }' \
        '{ enabled = 0; name = "EVENT_TODO"; }' \
        '{ enabled = 0; name = "IMAGES"; }' \
        '{ enabled = 0; name = "BOOKMARKS"; }' \
        '{ enabled = 0; name = "MUSIC"; }' \
        '{ enabled = 0; name = "MOVIES"; }' \
        '{ enabled = 0; name = "FONTS"; }' \
        '{ enabled = 0; name = "MENU_OTHER"; }' \
        '{ enabled = 0; name = "SOURCE"; }' \
        '{ enabled = 0; name = "MENU_SPOTLIGHT_SUGGESTIONS"; }' \
        '{ enabled = 0; name = "MENU_CONVERSION"; }' \
        '{ enabled = 0; name = "MENU_DEFINITION"; }'

    killall "Finder" &> /dev/null
    killall "cfprefsd" &> /dev/null
}
task "Finder & Spotlight" _finder_and_spotlight

_other_apps() {
    ####################
    ###   Terminal   ###
    ####################

    # Only use UTF-8 in Terminal.app
    defaults write com.apple.terminal StringEncodings -array 4

    # Enable Secure Keyboard Entry in Terminal.app
    # See: https://security.stackexchange.com/a/47786/8918
    defaults write com.apple.terminal SecureKeyboardEntry -bool true

    # Make the focus automatically follow the mouse
    defaults write com.apple.terminal FocusFollowsMouse -string true

    # Hide line marks
    defaults write com.apple.Terminal ShowLineMarks -int 0

    # Disable ⌘+S and ⌘+P
    defaults write com.apple.terminal NSUserKeyEquivalents -dict-add "Export Text As..." nil
    defaults write com.apple.terminal NSUserKeyEquivalents -dict-add "Print..." nil

    # Ensure TouchID when using sudo
    if ! grep -q "pam_tid.so" "/etc/pam.d/sudo"; then
        sudo sh -c "echo \"auth sufficient pam_tid.so\" >> /etc/pam.d/sudo"
    fi


    #############################
    ####   Activity Monitor   ###
    #############################

    # Show the main window when launching Activity Monitor
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

    # Visualize CPU usage in the Activity Monitor Dock icon
    defaults write com.apple.ActivityMonitor IconType -int 5

    # Show all processes in Activity Monitor
    defaults write com.apple.ActivityMonitor ShowCategory -int 0

    # Sort Activity Monitor results by CPU usage
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0


    #####################
    ###   App Store   ###
    #####################

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Enable debug menu
    defaults write com.apple.appstore ShowDebugMenu -bool true

    # Turn-on auto-update
    defaults write com.apple.commerce AutoUpdate -bool true

    # Enable automatic update check
    defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

    # Download updates in background
    defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

    # Install critical updates
    defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

    killall "App Store" &> /dev/null || :;


    ##################
    ###   Photos   ###
    ##################

    # Prevent Photos from opening automatically when devices are plugged in
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

    killall "Photos" &> /dev/null || :;


    ##################
    ###   Chrome   ###
    ##################

    # Disable backswipe
    defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

    # Expand print dialog by default
    defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

    # Use system-native print preview dialog
    defaults write com.google.Chrome DisablePrintPreview -bool true

    killall "Google Chrome" &> /dev/null || :;


    #####################
    ###   Text Edit   ###
    #####################

    # Open and save files as UTF-8 encoded
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

    # Use plain text mode for new documents
    defaults write com.apple.TextEdit RichText 0

    killall "TextEdit" &> /dev/null || :;
}
task "Applications" _other_apps
