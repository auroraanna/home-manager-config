{ config, pkgs, ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = false;
    };
  };

  home.file.".config/mimeapps.list".source = ./mimeapps.list;

  home = {
    packages = with pkgs; [
      xdg-utils
    ];
  };
}
