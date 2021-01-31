# dotfiles

This is my from scratch setup for my work MacBook.  It's a work in progress, but I'm getting there.

## Pre-requisites

- ```git``` - Install either as a download or by installing the Apple Command Line Tools
  - ```sudo xcode-select --install```
- Finish all of the initial setup (MSC) and updates (Apple) so nothing is pending. 

## Installation
- Install [YADM](https://yadm.io)
```bash
sudo curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && sudo chmod a+x /usr/local/bin/yadm
yadm clone -b main --bootstrap https://github.com/deversmann/dotfiles.git
```

## Description

Steps covered by the bootstrap:

- Install [Homebrew](https://brew.sh)
- Run brew bundle and install everything in `.Brewfile` including App Store stuff (this step takes forever)
- Configure iTerm2
- Link up Homebrew's OpenJDK to the MacOS system libs
- Configure git
- Install [OMZ](https://ohmyz.sh/)
- Install ansible using pip

### Notes for later

- after xcode: ```sudo xcodebuild -license accept```
- yadm bootstrap? - [https://github.com/TheLocehiliosan/yadm/blob/master/bootstrap](https://github.com/TheLocehiliosan/yadm/blob/master/bootstrap)
- ssh keys
- Vagrant
  - Vagrant plugins: registration
  - ```~/.vagrant.d/Vagrantfile``` with registration password
- RH MSC (Munki) optional installs (check for RH machine first)
