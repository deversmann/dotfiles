#!/bin/bash
#
# Adds entries to the Managed Software Center list of "My Items" and then 
# triggers the MSC to open and update. The script takes as arguments the 
# MSC names of the apps to be installed (separated by spaces).
#
# Required to be run as root

if ! [ $(id -u) = 0 ]; then
   echo "Must run as root"
   exit 1
fi

apps=$@
list_file='/Library/Managed Installs/manifests/SelfServeManifest.plist'

if ! [[ -e "${list_file}" ]]; then
  defaults write "${list_file}" '{"managed_installs" = (); "managed_uninstalls" = (); }';
fi

if ! [[ -w "${list_file}" ]]; then
  echo "Problem writing to the proper file"
  exit 1 
fi

for app in ${apps[@]}; do
  existing=`plutil -extract "managed_installs" json "${list_file}" -o -`
  if ! [[ ${existing} =~ ${app} ]]; then
    plutil -insert managed_installs.0 -string "${app}" "${list_file}"
  fi
done

plutil -convert xml1 "${list_file}"
mv "${list_file}" "${list_file%.plist}"
open munki://updates
/usr/local/munki/managedsoftwareupdate --auto
