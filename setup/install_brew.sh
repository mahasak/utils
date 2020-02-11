#!/usr/bin/env bash

sudo -v # ask for password only at the beginning

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

install_homebrew() {
    # install brew
    fancy_echo "🍺 Step #1: Homebrew"
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        fancy_echo "🍺 Installing Homebrew ..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    configure_homebrew
}

configure_homebrew() {
    fancy_echo "🍺 Updating Homebrew ..."
    brew update
    fancy_echo "🍺 Upgrading formula ..."
    brew upgrade
    fancy_echo "🍺 Tapping homebrew/cask-versions ..."
    brew tap homebrew/cask-versions
    fancy_echo "🍺 Tapping phinze/homebrew-cask ..."
    brew tap phinze/homebrew-cask
    fancy_echo "🍺 Tapping mas-cli/tap ..."
    brew tap mas-cli/tap
    fancy_echo "🍺 Tapping homebrew/cask-fonts ..."
    brew tap homebrew/cask-fonts
}

install_cli() {
    binaries=(
        ack
        coreutils
        cowsay
        curl
        docker
        docker-machine
        exiv2
        figlet
        fish
        findutils
        go
        git
        git-lfs
        git-flow
        git-extras
        hub
        imagemagick
        libffi
        lua
        lynx
        mackup
        mas
        node
        nvm
        openssl
        pandoc
        python3
        p7zip
        pkg-config 
        pigz
        pv
        rename  
        rhino
        speedtest_cli
        ssh-copy-id
        thefuck
        tldr
        tree
        vim
        webkit2png
        when
        wget
        yarn
        zopfli
    )
    fancy_echo "🍺 Installing homebrew CLI apps ..."
    brew install ${binaries[@]}
}

install_app() {
    apps=(
        1password
        alfred
        calibre
        colorpicker-developer
        cyberduck
        datagrip
        disk-inventory-x
        diffmerge
        divvy
        dropbox
        firefox
        gimp
        google-drive-file-stream
        harvest
        hex-fiend
        insomnia
        istat-menus
        keybase
        opera
        postman
        sequel-pro
        skype
        spotify
        slack
        db-browser-for-sqlite
        sublime-text
        the-unarchiver
        vagrant
        virtualbox
        visual-studio-code
        vlc
        wireshark
        witch
        xquartz
    )
    # exclude (google-chrome,iterm2, java)
    fancy_echo "🍺 Installing homebrew cask apps ... excludes (google-chrome,iterm2, java)"
    brew cask install --appdir="/Applications" ${apps[@]}
}

install_devops() {
    devops=(
        ansible
        consul
        nomad
        packer
        terraform
        vault
    )
    fancy_echo "🍺 Installing DevOps tools ..."
    brew install ${devops[@]}
}

install_quicklooks() {
    quicklooks=(
        qlcolorcode
        qlimagesize 
        qlmarkdown
        qlprettypatch
        qlstephen
        quicklook-csv
        quicklook-json
        suspicious-package
        webpquicklook
    )
    fancy_echo "🍺 Installing Quicklooks ..."
    brew cask install ${quicklooks[@]}
}

install_java() {
    java=(
        sbt
        ammonite-repl
        kotlin
        maven
        gradle
    )
    fancy_echo "🍺 Installing Java Ecosystem ..."
    brew install ${java[@]}
}

install_haskell() {
    fancy_echo "🍺 Installing Haskell Ecosystem ..."
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

}

# Step 1: Install Homebrew & configuring Homebrew
install_homebrew    
install_cli
install_app
install_devops
install_quicklooks
install_java
#install_haskell
