# brew install rcmdnk/file/brew-file 
# Make sure using latest Homebrew
update

# Update already-installed formula
upgrade

# Add Repository
#tap phinze/homebrew-cask || true
#tap homebrew/binary || true

# Packages for development
install zsh
install git
install vim
install tmux
install z
install Caskroom/cask/xquartz
install graphicsmagick
install ffmpeg
install imagemagick
install autoconf
install ctags
install coreutils
install reattach-to-user-namespace 

# Packages for brew-cask
install brew-cask

# .dmg from brew-cask
#cask install google-chrome
#cask install virtualbox
cask install vagrant

# Remove outdated versions
cleanup
