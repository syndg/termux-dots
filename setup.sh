#! /bin/bash

# A script to install all the important stuff during the initial setup

# Colours
R='\033[1;31m'
B='\033[1;34m'
C='\033[0;36m'
G='\033[1;32m'
W='\033[1;37m'
Y='\033[1;33m'

export IMP_PACKAGES="git python openssh ruby yarn stow zsh neovim"
export PY_MODULES="telethon autopep8 python-language-server"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Initial pkg upgrades
echo
echo -e $Y" [*] Upgrading all the existing packages..."
echo
pkg upgrade -y

# Most important packages
echo
echo
echo -e $R"[*] Installing important packages..."
echo
for i in $IMP_PACKAGES; do
    pkg install $i -y
done

# Set zsh as the default shell
echo
echo
echo -e $G"[*] Setting zsh as the default shell..."
chsh -s zsh

# nvim env
echo
echo
echo -e $C"[*] Setting up neovim env..."
echo
gem install neovim
yarn global add neovim
pip install pynvim

# python
echo
echo
echo -e $R"[*] Installing required python modules..."
echo
for i in $PY_MODULES; do
    pip install $i
done

# Setup OH-MY-ZSH
echo
echo
echo -e $G"[*] Setting up OH-MY-ZSH..."
echo
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh --depth 1
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions # auto-suggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting #syntax-highlighting

# Clone neovim-config from ny fork (check out https://github.com/blacksuan19/init.nvim)
echo
echo
echo -e $C"[*] Setting up neovim config..."
git clone https://github.com/sinchandasgupta/init.nvim $HOME/.config/nvim
cd $HOME/.config/nvim
rm coc-settings.json init.vim

# Setup my own termux-dots
echo
echo
echo -e $Y"[*] Setting up your dots..."
echo
git clone https://github.com/sinchandasgupta/termux-dots.git $HOME/.mydots

if [ -d $HOME/.termux ]; then
    rm -rf $HOME/.termux && echo "Removing existing .termux folder"
fi

cd $HOME/.mydots
cp nvim/.config/nvim/init.vim ~/.config/nvim
cp nvim/.config/nvim/coc-settings.json ~/.config/nvim
stow termux
stow zsh

# Cloning termux-style (just-in-case)
echo
echo
echo -e $C"[*] Cloning termux-style from your fork..."
echo
git clone https://github.com/sinchandasgupta/termux-style.git $HOME/tstyle

# Cloning Kensurbot (lmao)
echo
echo
echo -e $Y"[*] Cloning your fav Kensurbot..."
git clone https://github.com/KenHV/Kensurbot.git $HOME/kensurbot

# Setup Pure theme for zsh
echo
echo
echo -e $C"[*] Setting up Pure theme for zsh..."
echo
cd ~/.oh-my-zsh/custom && \
git clone https://github.com/sindresorhus/pure && \
ln -s pure/pure.zsh-theme . && \
ln -s pure/async.zsh .

exit
