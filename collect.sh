#!/bin/bash

FILES=(.asoundrc .config/awesome/rc.lua
.config/awesome/themes/solarized/theme.lua .config/gtk-3.0/settings.ini
.config/mc/ini .conkyrc .dircolors .emacs .gtkrc-2.0 .inputrc .ncmpcpp/config
.rtorrent.rc .screenrc .tmux.conf .vimrc .xbindkeysrc.scm .Xdefaults .xinitrc
.xpdfrc .yaourtrc .zprofile .zshrc)

for f in ${FILES[@]}; do
    [[ -n `echo ${f} | grep /` ]] && mkdir -p ${f%/*}
    cp -R ~/${f} ${f%/*}
done

git add .
git commit -m "`date`"
