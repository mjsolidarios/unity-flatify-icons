#! /usr/bin/env bash

# configurations
v="0.0.1"
echo "Unity file_listatify Icons $v"
tmp_dir="/tmp/unity-flatify-$(date +%s)"
ifp="/usr/share/unity/icons/" # icon fragment path

# notify helper function
notify(){
  g=$(tput setaf 2) # green
  r=$(tput sgr 0) # reset
  echo ">>> ${g}$1 ${r}"
  sleep 1
}

# main function
flatify(){

  notify "Backing up Unity launcher icon files to tmp."
  mkdir "$tmp_dir"
  # read the file list and copy to tmp directory
  cat file_list.txt | xargs -I % cp $ifp% $tmp_dir

  notify "Copying the flat launcher icons to tmp."
  cp assets/unity-launcher-flat-icons.tar.gz $tmp_dir

  notify "Entering the tmp directory."
  cd $tmp_dir

  notify "Compressing backup files."
  tar -zcf launcher-icons-backup.tar.gz *

  notify "Copying the backup file to "$ifp
  sudo cp launcher-icons-backup.tar.gz $ifp

  notify "Replacing the launcher icons."
  sudo tar --overwrite -xzf unity-launcher-flat-icons.tar.gz -C $ifp

  notify "Cleaning up..."
  rm -rf "$tmp_dir"

  notify "The Unity launcher icons have been replaced successfuly!"
  notify "Please log in again to check it out."
  sleep 2
}

# execute the main function
flatify "$@"
