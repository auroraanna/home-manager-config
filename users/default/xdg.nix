{ config, pkgs, ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image" = [ "gthumb.desktop" ];
        "text" = [ "codium.desktop" ];
        "x-scheme-handler/http" = [ "brave.desktop" ];
        "x-scheme-handler/https" = [ "brave.desktop" ];
      };
    };
  };
}
