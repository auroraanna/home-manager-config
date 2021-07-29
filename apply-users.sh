#!/bin/sh
pushd /git-repos/nixos-config-desktop
nix build .#homeManagerConfigurations.papojari.activationPackage
./result/activate
popd