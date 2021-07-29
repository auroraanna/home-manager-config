#!/bin/sh
pushd /git-repos/nixos-config-desktop
sudo nixos-rebuild switch --flake .#
popd