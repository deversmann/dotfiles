
git clone --bare https://github.com/deversmann/dotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
config checkout
if [ $? -ne 0 ]; then
    config checkout 2>&1 | egrep "^\s+" | awk '{$1=$1}1' | xargs -I{} dirname ".config-backup/{}" | xargs -I{} mkdir -p {}
    config checkout 2>&1 | egrep "^\s+" | awk '{$1=$1}1' | xargs -I{} mv "{}" ".config-backup/{}"
    config checkout
fi;
config config status.showUntrackedFiles no
