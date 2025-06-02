#!/bin/bash

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
LRED="\033[91m"
LMAGENTA="\033[95m"
BGRED="\033[41m"
RESET="\033[0m"

echo
echo -e "      /      /  ${RED}_   _       ${RESET}/       /       /       /       /    ${LMAGENTA}_  ${RESET}/       //xx"
echo -e "     /     ${LRED}󰉝   ${RED}| | / /     ${RESET}/       ${GREEN}_       ${RESET}/       ${BLUE}___      ${MAGENTA}__  ${LMAGENTA}| |   ${RESET}     //xxx"
echo -e "${CYAN}\_O__     ${LRED}'    ${RED}| |/ /   ${LRED}_   ${YELLOW}____  ${GREEN}| | _   ${CYAN}____    ${BLUE}/ __\   ${MAGENTA}/ __\ ${LMAGENTA}| |  ${RESET}     //xxxx"
echo -e "  ${CYAN}\__    ${LRED}'     ${RED}|   (   ${LRED}| | ${YELLOW}/  __\ ${GREEN}| |/ / ${CYAN}/    \  ${BLUE}_| |_   ${MAGENTA}_| |_  ${LMAGENTA}|_| ${RESET}     //xxxxx"
echo -e "  ${CYAN}|  \, ${LRED}'      ${RED}| |\ \  ${LRED}| | ${YELLOW}| (__  ${GREEN}|   (  ${CYAN}| () | ${BLUE}|__ __| ${MAGENTA}|__ __|  ${LMAGENTA}_ ${RESET}     //xxxxx/"
echo -e " ${CYAN}/_            ${RED}|_| \_\ ${LRED}|_| ${YELLOW}\___ / ${GREEN}|_|\_\ ${CYAN}\____/   ${BLUE}|_|     ${MAGENTA}|_|   ${LMAGENTA}|_|${RESET}    //xxxxx//"
echo
echo
echo "Welcome to the kickoff script. The following is about to take place:"
echo "  - XCode Command Line Tools installation"
echo "  - Path configuration for Python modules"
echo "  - Download and run yadm to download dotfiles and run bootstrap"
echo "  - Decryption of encrypted dotfiles (requires password)"
echo "  - Cleanup"
echo

echo -e "Installing ${RED}XCode Command Line Tools${RESET} if needed."
if ! xcode-select --print-path &>/dev/null; then
    xcode-select --install &>/dev/null
    echo -n "Waiting for ${LRED}XCode Command Line Tools${RESET} installation to finish."
    until $(xcode-select --print-path &> /dev/null); do
        echo -n '.';
        sleep 5;
    done
    echo;
else
    echo -e "${YELLOW}XCode Command Line Tools${RESET} already installed."
fi

echo -e "Updating ${GREEN}PATH${RESET} for ${CYAN}Python${RESET} modules and persisting to ${BLUE}.zprofile${RESET}"
export PATH="$(python3 -m site --user-base)/bin:$PATH"
echo >> ~/.zprofile
echo "PATH=\"$(python3 -m site --user-base)/bin:\$PATH\"" >> ~/.zprofile
echo "export PATH" >> ~/.zprofile

echo -e "Acquiring a temporary copy of ${MAGENTA}yadm${RESET}."
mkdir -p ~/tmp
curl -fLo ~/tmp/yadm https://github.com/yadm-dev/yadm/raw/master/yadm && chmod a+x ~/tmp/yadm

echo -e "Cloning ${LMAGENTA}dotfiles${RESET} and kicking off ${RED}bootstrap${RESET}."
pushd ~
tmp/yadm clone --bootstrap https://github.com/deversmann/dotfiles

echo -e "Back from ${LRED}bootstrap${RESET}"
echo -e "Decrypting encrypted ${YELLOW}dotfiles${RESET}. ${BGRED}${BLACK}Password will be required for decryption.${RESET}"
tmp/yadm decrypt

echo -e "Cleaning up"
rm tmp/yadm
popd

echo -e "All done!!! ${BGRED}${BLACK}Open new Terminal window to update paths and load scripts.${RESET}"
echo -e "If you want to not checkout the ${GREEN}LICENSE${RESET} and ${CYAN}README.md${RESET} files, execute the "
echo -e "following after authenticating:"
echo -e "    ${MAGENTA}yadm sparse-checkout set --no-cone '/*' '!README.md' '!LICENSE'${RESET}"
echo
