#!/bin/sh
pushd system
sudo nixos-rebuild switch -I nixos-config=./configuration-amd.nix
popd