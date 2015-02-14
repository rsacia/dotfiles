#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Turn on compositing
compton --config ~/.compton.conf  -b

# Set background image
sh ~/.fehbg &

# Set keyboard layout
setxkbmap dvorak
xmodmap -e "clear lock" #disable caps lock switch
xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape

# Set X styles
xrdb ~/.Xresources

exec i3

