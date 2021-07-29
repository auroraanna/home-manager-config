#!/bin/sh
pushd users/papojari
home-manager switch -f ./home.nix
popd