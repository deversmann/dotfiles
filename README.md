# dotfiles

## Installation
- Install [YADM](https://yadm.io)
```bash
curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/local/bin/yadm
yadm clone --bootstrap https://github.com/deversmann/dotfiles.git
```

## Description

Steps covered by the bootstrap:

- Install [Homebrew](https://brew.sh)
- Run brew bundle and install everything in `.Brewfile` including App Store stuff
- Configure iTerm2
- Link up Homebrew's OpenJDK to the MacOS system libs
- Configure git
- Install [OMZ](https://ohmyz.sh/)
- Install ansible using pip

