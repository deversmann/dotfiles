#!/bin/bash

# New machine kickoff does the following:
# - make sure macOS Developer Command Line Tools are installed
# - download a temporary copy of yadm
# - kickoff the yadm download and bootstrap

# Install macOS Developer Command Line Tools if needed
if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install &>/dev/null
fi

# Acquire a temporary copy of yadm
curl -fLo ~/tmp/yadm https://github.com/yadm-dev/yadm/raw/master/yadm && chmod a+x ~/tmp/yadm

# Start the party
pushd ~
~/tmp/yadm clone --bootstrap https://github.com/deversmann/dotfiles
~/tmp/yadm decrypt
popd
