#!/bin/sh
pushd /git-repos/nixos-config-desktop
nix flake update #--recreate-lock-file
popd