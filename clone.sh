#!/bin/sh

echo "Prepping environment"
# Check for Oh My Zsh and install if we don't have it
if [ ! -d ~/code]; then
    mkdir ~/code
fi

echo "Cloning repositories..."

SITES=$HOME/Sites
LARAVEL=$SITES/laravel

# Personal
#git clone git@github.com:driesvints/driesvints.com.git $SITES/driesvints.com
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
echo "Installing Doom Emacs"
~/.emacs.d/bin/doom install

git clone --depth 1 https://github.com/ciph3rz/offensive-docker ~/code/
