#!/bin/sh
PROGRAMS="mako neofetch rofi swappy sway waybar wofi zsh"

pushd users/all/

stow -nvSt ~ $PROGRAMS

echo "Do you want do stow? Y/N"
read INPUT

if [ INPUT="Y" ]
then
	stow -vSt ~ $PROGRAMS
fi

popd