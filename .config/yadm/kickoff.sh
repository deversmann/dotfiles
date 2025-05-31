#!/bin/bash

# New machine kickoff does the following:
# - make sure XCode Command Line Tools are installed
# - download a temporary copy of yadm
# - kickoff the yadm download and bootstrap

# Install XCode Command Line Tools if needed
if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install &>/dev/null
fi

# Wait until XCode Command Line Tools installation has finished.
until $(xcode-select --print-path &> /dev/null); do
    echo '.';
    sleep 5;
done
echo '\n';

# Acquire a temporary copy of yadm
mkdir -p ~/tmp
curl -fLo ~/tmp/yadm https://github.com/yadm-dev/yadm/raw/master/yadm && chmod a+x ~/tmp/yadm

# Start the party
pushd ~
~/tmp/yadm clone --bootstrap https://github.com/deversmann/dotfiles
~/tmp/yadm decrypt
popd
