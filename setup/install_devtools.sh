#!/usr/bin/env bash


shell_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "$fmt\\n" "$@"
}

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
      printf "%s\\n" "$text" >> "$zshrc"
    else
      printf "\\n%s\\n" "$text" >> "$zshrc"
    fi
  fi
}

# Asking for macbook administrator password
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Welcome script
shell_echo "Macbook Developer Setup Script"

if ! command -v brew >/dev/null; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install coreutils https://github.com/coreutils
brew install coreutils

sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install wget --with-iri
brew install findutils
brew install gnu-sed --with-default-names

brew install python
brew install python3
#brew install vim --override-system-vi

# Install webfont tools
brew tap bramstein/webfonttools
brew install sfnt2woff-zopfli
brew install sfnt2woff
brew install woff2

brew install watch
brew install irssi geoip links nmap wget htop

# Install CTF tools
# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng bfg binutils binwalk cifer dex2jar dns2tcp fcrackzip foremost hashpump hydra john knock netpbm nmap
brew install pngcheck socat sqlmap tcpflow tcpreplay tcptrace ucspi-tcp xz

brew install ack
brew install dark-mode
brew install exiv2
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install hub
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install zopfli
brew install pkg-config libffi
brew install pandoc
brew install figlet
brew install cowsay
brew install tldr
brew install thefuck

# Core casks
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java
brew cask install --appdir="~/Applications" xquartz

# Development tool casks
brew cask install --appdir="/Applications" sublime-text
brew cask install --appdir="/Applications" atom
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
brew cask install --appdir="/Applications" macdown

# Misc casks
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" 1password
#brew cask install --appdir="/Applications" gimp
#brew cask install --appdir="/Applications" inkscape
#brew cask install --appdir="/Applications" mactex

# Install Docker, which requires virtualbox
brew install docker

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

brew install nvm

brew install tmux

# Install zsh
brew install zsh

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install zsh autosuggestion
brew install zsh-autosuggestions
append_to_zshrc 'source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'

# Install zsh autocompletions
brew install zsh-completions
append_to_zshrc 'fpath=(/usr/local/share/zsh-completions $fpath)'
append_to_zshrc 'autoload -Uz compinit'
append_to_zshrc 'compinit'
chmod go-w '/usr/local/share'
rm -f ~/.zcompdump; compinit

# Install Powerline font
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

#brew install postgresql
#brew install mongo
#brew install redis
#brew install elasticsearch

# Remove outdated versions from the cellar.
brew cleanup

# install ammonite shell
sudo sh -c '(echo "#!/usr/bin/env sh" && curl -L https://github.com/lihaoyi/Ammonite/releases/download/1.1.2/2.12-1.1.2) > /usr/local/bin/amm && chmod +x /usr/local/bin/amm' && amm