{ config, pkgs, lib, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      #promptInit is located in /default.nix because Home Manager doesn't have this option.
      history = {
        path = "$HOME/.cache/zshhistory";
        size = 10000;
        save = 10000;
      };
    };
    starship = {
      enable = true;
    };
  };
  home.file.".config/zsh/zshrc".source = ./zshrc;
}