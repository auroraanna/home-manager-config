#!/bin/sh

pushd users/all/

stow -nvSt ~ *

echo "Do you want do stow? Y/N"
read INPUT

if [ INPUT="Y" ]
then
	stow -vSt ~ *
fi

popd