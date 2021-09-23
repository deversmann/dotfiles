#!/bin/bash

echo "** Creating repo files"
git clone --bare https://github.com/deversmann/dotfiles.git $HOME/.cfg
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "** Repo creation failed. Exiting..."
    exit $exit_code
fi;

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

echo "** Attempting checkout of home dir files"
config checkout &>/dev/null
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "** Backing up files that would be overwritten to .config-backup:"
    config checkout 2>&1 | egrep "^\s+" | awk '{$1=$1}1' | xargs -I{} dirname ".config-backup/{}" | xargs -I{} mkdir -p {}
    config checkout 2>&1 | egrep "^\s+" | awk '{$1=$1}1' | tee /dev/tty | xargs -I{} mv "{}" ".config-backup/{}"
    echo "** Attempting checkout of home dir files again"
    config checkout
    exit_code=$?
fi;
if [ $exit_code -ne 0 ]; then
    echo "** Checkout completely failed. Some files may be backed up to .config-backup. Exiting..."
    exit $exit_code
fi;
echo "** Checkout successful"
config config status.showUntrackedFiles no
config push -u origin main


echo "0 = $0 ; 1 = $1"

if [ "$1" -eq "-2" ]; then
    echo "stage 2"

    # commented out till I test if it is "idempotent-ish" at all
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # brew bundle --global

    pushd ~/.bin
    ansible-playbook main.yml
    popd
fi;
