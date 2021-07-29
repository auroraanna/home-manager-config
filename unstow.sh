#!/bin/sh

pushd users/all/

stow -nvDt ~ *

echo "Do you want to unstow? Y/N"
read INPUT

if [ INPUT="Y" ]
then
	stow -vDt ~ *
fi

popd