#!/bin/bash

# New machine kickoff does the following:
# - make sure XCode Command Line Tools are installed
# - download a temporary copy of yadm
# - kickoff the yadm download and bootstrap

echo "Installing XCode Command Line Tools if needed."
if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install &>/dev/null
    echo -n "Waiting XCode Command Line Tools installation to finish."
    until $(xcode-select --print-path &> /dev/null); do
        echo -n '.';
        sleep 5;
    done
    echo;
else
    echo "XCode Command Line Tools already installed."
fi

echo "Updating PATH for Python and persisting to .zprofile"
export PATH="$(python3 -m site --user-base)/bin:$PATH"
echo >> ~/.zprofile
echo "PATH=\"$(python3 -m site --user-base)/bin:\$PATH\"" >> ~/.zprofile
echo "export PATH" >> ~/.zprofile

echo "Acquiring a temporary copy of yadm."
mkdir -p ~/tmp
curl -fLo ~/tmp/yadm https://github.com/yadm-dev/yadm/raw/master/yadm && chmod a+x ~/tmp/yadm

echo "Cloning dotfiles and kicking off bootstrap."
pushd ~
tmp/yadm clone --bootstrap https://github.com/deversmann/dotfiles
echo "Decrypting encrypted dotfiles."
tmp/yadm decrypt

echo "Cleaning up"
rm tmp/yadm
popd
