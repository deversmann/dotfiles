#!/bin/sh
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
config checkout
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "** Backing up files that would be overwritten to .config-backup"
    config checkout 2>&1 | egrep "^\s+" | awk '{$1=$1}1' | xargs -I{} dirname ".config-backup/{}" | xargs -I{} mkdir -p {}
    config checkout 2>&1 | egrep "^\s+" | awk '{$1=$1}1' | xargs -I{} mv "{}" ".config-backup/{}"
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
