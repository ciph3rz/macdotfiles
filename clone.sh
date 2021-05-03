#!/bin/sh

echo "Cloning repositories..."

SITES=$HOME/Sites
BLADE=$SITES/blade-ui-kit
EVENTSAUCE=$SITES/eventsauce
LARAVEL=$SITES/laravel

# Personal
#git clone git@github.com:driesvints/driesvints.com.git $SITES/driesvints.com
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
