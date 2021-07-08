#!/bin/sh

echo "Prepping environment"
# Check for Oh My Zsh and install if we don't have it
if [ ! -d $HOME/code]; then
    mkdir $HOME/code
fi

echo "Cloning repositories..."

SITES=$HOME/Sites
ZPATH=$HOME/.oh-my-zsh/custom

# Personal
#git clone git@github.com:driesvints/driesvints.com.git $SITES/driesvints.com
# zsh themes
echo "Cloning zsh repos"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZPATH/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZPATH/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZPATH/plugins/zsh-syntax-highlighting
# Cloning Powerline fonts and installing
echo "cloning powerline fonts"
git clone https://github.com/powerline/fonts.git --depth=1 ~/code/fonts
cd fonts
./install.sh

echo "cloning Doom Emacs"
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
echo "Installing Doom Emacs"
~/.emacs.d/bin/doom install

# git clone --depth 1 https://github.com/ciph3rz/offensive-docker ~/code/
