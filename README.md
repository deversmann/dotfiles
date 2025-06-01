# Damien's Dotfiles Project

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/deversmann/dotfiles/HEAD/.config/yadm/kickoff.sh)"
```

## Description
Uses [YADM](https://yadm.io) to manage files.

The [`kickoff.sh`](.config/yadm/kickoff.sh) file in curl-bash above does the following:
1. Install XCode Command Line Tools if not already installed
   - This gets us `git` and `python`
2. Update the `PATH` for `python`
3. Download a temp copy of `yadm`
4. Pull down the dotfiles and starts the  [`bootstrap`](.config/yadm/bootstrap)
5. Decrypt the encrypted dotfiles with the user proppted password
6. Clean up

The [`bootstrap`](.config/yadm/bootstrap) file is run automatically by `yadm` does the following:
1. Install `ansible` via Python `pip` if it is not already installed
2. Download a copy of my [mac_dev_playbook](https://github.com/deversmann/mac_dev_playbook) project
3. Run the playbook, prompting for BECOME password if needed.
4. Clean up

## TODOs
- [ ] Improve logging/feedback
- [ ] Add the ability to do different installs based on the machine being installed on
  - This is a change that needs to be made in tandem with the [mac_dev_playbook](https://github.com/deversmann/mac_dev_playbook)
- [ ] Improve documentation
- [ ] Improve reusability

## Credit where credit is due
Inspiration for some of the functionalities in this project has come from:
- https://yadm.io
- https://github.com/geerlingguy/mac-dev-playbook
- https://gist.github.com/mrlesmithjr/f3c15fdd53020a71f55c2032b8be2eda
- https://github.com/mrlesmithjr/dotfiles

