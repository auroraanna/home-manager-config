#!/bin/sh
ROOT="/git-repos/nixos-config"
SECRETS=".secrets"

pushd "$ROOT"

if [ "$1" = "--update" ]
then
nix flake update #--recreate-lock-file
elif [ "$1" = "--apply-system" ]
then
sudo nixos-rebuild switch --flake .#
elif [ "$1" = "--apply-users" ]
then
nix build .#homeManagerConfigurations.papojari.activationPackage
./result/activate
elif [ "$1" = "--lock" ]
then
tar -cf $SECRETS.tar $SECRETS/* &&
rm -rf $SECRETS &&
age -p $SECRETS.tar > $SECRETS.tar.age &&
rm -rf $SECRETS.tar
elif [ "$1" = "--unlock" ]
then
age -d $SECRETS.tar.age > $SECRETS.tar &&
rm -rf $SECRETS.tar.age &&
tar -xf $SECRETS.tar $SECRETS &&
rm -rf $SECRETS.tar
else
	echo "
Usage: manage.sh [OPTION]

Options:

--update					
--apply-system		
--apply-users			
--lock						
--unlock					
	"
fi

popd