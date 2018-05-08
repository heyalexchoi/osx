#! /bin/sh

###########
#
#    First, download & install XCode Dev Tools — https://developer.apple.com/downloads/
#
###########

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# borrowed from https://github.com/thoughtbot/laptop
append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

echo "Checking for Homebrew..."
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# echo "Setting brew permissions..."
# chown -R $USER /usr/local/include
# chown -R $USER /usr/local/lib/pkgconfig

# Inspired by http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac

echo "Updating brew..."
brew update

echo "Installing GNU core utils (those that come with OS X are outdated)..."
brew install coreutils

echo "Installing more recent versions of some OS X tools..."
# Error: homebrew/dupes was deprecated. This tap is now empty as all its formulae were migrated.
#brew tap homebrew/dupes
#brew install homebrew/dupes/grep

# TODO add utils to zsh path

binaries=(
  ack
  autojump
  cairo
  curl
  heroku
  casperjs
  ffmpeg
  git
  git-extras
  gpg2
  grep
  imagemagick --with-webp
  mackup
  node
  postgresql
  pkg-config
  rbenv
  pyenv
  redis
  rhino
  ruby-build
  slimerjs
  tree
  unrar
  wget
  youtube-dl
  zopfli
  zsh
)

echo "Installing binaries..."
brew install ${binaries[@]}

echo "Cleaning up..."
brew cleanup

#Error: Cask 'brew-cask' is unavailable: '/usr/local/Homebrew/Library/Taps/caskroom/homebrew-cask/Casks/brew-cask.rb' does not exist.
#echo "Installing Cask..."
#brew install caskroom/cask/brew-cask

echo "Adding nightly/beta Cask versions..."
brew tap caskroom/versions

# Apps
apps=(

  # work
  rowanj-gitx
#  iterm2
  sublime-text
#  virtualbox

  # productivity, core, runtimes
#  caffeine
#  quicksilver
#  nvalt
#  appcleaner
#  osxfuse
  1password
#  spectacle
#  flash-npapi
  java
  caskroom/versions/java8 # elasticsearch needs this one
#  quicklook-json
#  macpar-deluxe
#  imageoptim
#  grandperspective
#  istat-menus
#  qlvideo # to display video files in finder and quick look
  postico
  docker

  # sharing
#  dropbox
#  google-drive

  # browsers
  google-chrome
#  firefoxnightly
#  webkit-nightly
  # torbrowser # cask broken rn

  # communication
#  skype

  # entertainment
  spotify
  vlc
#  hearthstone-eu # needs further installation

  # file sharing
#  utorrent # Error: Cask 'utorrent' is unavailable: No Cask with this name exists.
#  unison
)

echo "Installing apps to /Applications..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Don't forget to install Fleep separately (https://itunes.apple.com/us/app/fleep/id830440781?mt=12)"

#brew tap homebrew/fuse # Error: homebrew/fuse was deprecated. This tap is now empty as all its formulae were migrated.

echo "Installing other binaries that require Java, Fuse OS X, etc..."
post_binaries=(
  elasticsearch
#  ntfs-3g
)
brew install ${post_binaries[@]}

brew cask cleanup

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Customizing oh-my-zsh..."
mkdir -p ~/.oh-my-zsh-custom
wget https://raw.githubusercontent.com/heyalexchoi/osx/master/.oh-my-zsh-custom/aliases.zsh && mv aliases.zsh ~/.oh-my-zsh-custom
wget https://raw.githubusercontent.com/heyalexchoi/osx/master/.oh-my-zsh-custom/functions.zsh && mv functions.zsh ~/.oh-my-zsh-custom

# TODO: Customize `plugins=(git ...)` in .zshrc
# TODO: Add path to .oh-my-zsh-custom in .zshrc
# See https://github.com/maxim/dotfiles/blob/f381e8e6248184e453caa92284a10592b6914ef1/.zshrc#L8-L9

echo "Making autojump work with zsh..."
append_to_zshrc '[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh'

echo "Generating SSH keys (https://help.github.com/articles/generating-ssh-keys)..."
ssh-keygen -t rsa -C "heyalexchoi@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
open https://github.com/settings/ssh

# echo "Customizing OSX..."
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# TODO: triggers for quicksilver

echo "Installing translit..."
wget http://www.math.tamu.edu/~comech/tools/russian-translit-keyboard-layout-mac-os-x/russian-translit.keylayout && mv russian-translit.keylayout ~/Library/Keyboard\ Layouts/

echo "Installing nvm..."
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash

echo "Installing global node packages..."
node_packages=(
  caniuse-cmd
  git-open
  grunt
  gulp
  imageoptim-cli
  qunit
  watchify
)
npm install -g ${node_packages[@]}

echo "Customizing Sublime..."

# download and "install" Package Control
cp ./Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

# download and "install" Preferences file
cp ./Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

# download and "install" Packages file
cp ./Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

echo 'initializing rbenv and pyenv...'
rbenv init
pyenv init

echo 'copying ./.zshrc to ~/.zshrc and sourcing'
cp ./.zshrc ~/.zshrc
source ~/.zshrc

# sublime as default editor
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
'{LSHandlerContentType=public.plain-text;LSHandlerRoleAll=com.sublimetext.3;}'

cp ./.gitconfig ~/.gitconfig
