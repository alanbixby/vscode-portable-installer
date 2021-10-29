#!/usr/bin/env bash
# Created by Alan Bixby (October 29, 2021)
# GitHub: https://github.com/alanbixby/vscode-portable-installer

# TODO: Add uninstaller flag, add VSCode to PATH (tried but wasn't working)- potentially will just use a bash alias instead

VERSION="1.0.0"
SAVE_DIR=".bin"

if [ $OSTYPE != "linux-gnu" ]; then
  echo "Unsupported operating system: $OSTYPE, this script should be run in a 64 bit linux environment."
  exit 1
fi

while getopts ":v-:" flag; do
  case $flag in
    v)  
      echo "v$VERSION"
	    exit 1
	    ;;
    -)
      case ${OPTARG} in
          "version")
            echo "v$VERSION"
            exit 1
            ;;
          "help")
            echo "usage: ./vscode-portable-installer.sh
                    -v : view installer version
                    -h : view usage menu"
            exit 1
            ;;
      esac
      ;;
    *)
      echo "usage: ./vscode-portable-installer.sh
        -v : view installer version
        -h : view usage menu"
      exit 1
      ;;
  esac
done


while getopts ":v" FLAG; do
  case $FLAG in
    v | V | version)
	    echo "v$VERSION"
	    exit 1
	    ;;
    *)
	    echo "usage: ./vscode-portable-installer.sh
        -v : view installer version
        -h : view usage menu"
	    exit 1
	  ;;
  esac
done

if [ -f "$HOME/Desktop/VSCode.desktop" ]; then
  if [ -d "$HOME/$SAVE_DIR/VSCode-linux-x64" ]; then
    # if ! grep -q VSCode "$HOME/.bashrc"; then
    #   echo "export PATH=\"\$PATH:$HOME/$SAVE_DIR/VSCode-linux-x64/bin/code\"" >> $HOME/.bashrc
    #   echo "> Added VSCode to PATH."
    #   source "$HOME/.bashrc"
    # fi
    echo "VSCode is already installed in $HOME/$SAVE_DIR/VSCode-linux-x64; aborting"
    exit 1
  fi
fi

if [ ! -d "$HOME/$SAVE_DIR/VSCode-linux-x64" ]; then
  if [ ! -f "$HOME/$SAVE_DIR/VSCode-linux-x64.tar.gz" ]; then
	  mkdir $HOME/$SAVE_DIR
	  wget -O "$HOME/$SAVE_DIR/VSCode-linux-x64.tar.gz" "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
	  echo "Downloaded VSCode files"
  else
	  echo "Source files are already downloaded, proceeding to unzip."
  fi
else
  echo "Source files are already downloaded and unzipped, proceeding."
fi

if [ -f "$HOME/$SAVE_DIR/VSCode-linux-x64.tar.gz" ]; then
  tar -xvf "$HOME/$SAVE_DIR/VSCode-linux-x64.tar.gz" -C $HOME/$SAVE_DIR
  rm -r "$HOME/$SAVE_DIR/VSCode-linux-x64.tar.gz"
  echo "Extracted VSCode to $HOME/$SAVE_DIR"
fi
       
if [ ! -f "$HOME/Desktop/VSCode.desktop" ]; then
  echo "[Desktop Entry]
  Version=1.0
  Type=Application
  Name=Visual Studio Code
  Comment=
  Exec=$HOME/$SAVE_DIR/VSCode-linux-x64/bin/code --no-sandbox
  Icon=$HOME/$SAVE_DIR/VSCode-linux-x64/resources/app/resources/linux/code.png
  Path=
  Terminal=false
  StartupNotify=true
  " >> "$HOME/Desktop/VSCode.desktop"
  chmod +x "$HOME/Desktop/VSCode.desktop"
  echo "> Created Desktop Icon"
fi

if ! grep -q VSCode "$HOME/.bashrc"; then
  echo "export PATH=\"\$PATH:$HOME/$SAVE_DIR/VSCode-linux-x64/bin/code\"" >> $HOME/.bashrc
  echo "> Added VSCode to PATH."
  source "$HOME/.bashrc"
fi

echo "> VSCode is installed, and should be visible on your desktop."
