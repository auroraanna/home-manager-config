#!/bin/sh
PROGRAMS="mako neofetch rofi swappy sway waybar wofi zsh"

pushd users/all/

stow -nvDt ~ $PROGRAMS

echo "Do you want to unstow? Y/N"
read INPUT

if [ INPUT="Y" ]
then
	stow -vDt ~ $PROGRAMS
fi

popd