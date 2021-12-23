{ config, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      signing = {
        signByDefault = true;
      };
      lfs.enable = true;
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
