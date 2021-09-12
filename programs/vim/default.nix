{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = builtins.readFile ./vimrc;
    };
  };

  environment.systemPackages = with pkgs.vimPlugins; [
    chadtree
  ];
}