{ config, pkgs, ... }:

{
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "codium.desktop" ];
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "image/svg" = [ "brave-browser.desktop" ];
        "image/webp" = [ "org.gnome.gThumb.desktop" ];
        "image/png" = [ "org.gnome.gThumb.desktop" ];
        "image/jpeg" = [ "org.gnome.gThumb.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/mp4" = [ "mpv.desktop" ];
        "audio/x-wav" = [ "mpv.desktop" ];
        "audio/x-opus+ogg" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "application/json" = [ "codium.desktop" ];
        "application/pdf" = [ "brave-browser.desktop;org.gnome.Evince.desktop" ];
      };
    };
  };

  home = {
    packages = with pkgs; [
      xdg-utils
    ];
  };
}
